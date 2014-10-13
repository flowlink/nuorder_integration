require 'rubygems'
require 'httparty'
require 'securerandom'

module NuOrderConnector
  class Connector
    include HTTParty
    format :json
    attr_accessor :oauth_consumer_key, :oauth_consumer_secret, :endpoint, :oauth_verifier, :oauth_token, :oauth_token_secret

    def initialize(options)
      self.oauth_consumer_key = options[:consumer_key]
      self.oauth_consumer_secret = options[:consumer_secret]
      self.endpoint = options[:endpoint]
      self.oauth_token = options[:oauth_token]
      self.oauth_token_secret = options[:oauth_token_secret]
      self.class.base_uri endpoint
    end

    def api_initiate
      options = {
        headers: get_oauth_headers('GET', '/api/initiate', { 'application_name' => 'wombat_integration', 'oauth_callback' => 'oob' })
      }
      response = self.class.get('/api/initiate', options)
      self.oauth_token = response['oauth_token']
      self.oauth_token_secret = response['oauth_token_secret']
      response
    end

    def get_oauth_token
      raise 'No oauth_verifier' unless oauth_verifier
      options = {
        headers: get_oauth_headers('GET', '/api/token', { 'oauth_verifier' => oauth_verifier })
      }
      response = self.class.get('/api/token', options)
      self.oauth_token = response['oauth_token']
      self.oauth_token_secret = response['oauth_token_secret']
      response
    end

    def get(url, params = nil)
      options = {
        headers: get_oauth_headers('GET', url),
        query: params
      }
      response = self.class.get(url, options)
      validate_response(response)
    end

    def post(url, params = nil)
      response = self.class.post(url, build_params('POST', url, params))
      validate_response(response)
    end

    def put(url, params = nil)
      response = self.class.put(url, build_params('PUT', url, params))
      validate_response(response)
    end

    private

    def build_params(type, url, params = nil)
      options = {
        headers: get_oauth_headers(type, url),
      }
      options.merge!( { body: params.to_json } ) if params
      options
    end

    def validate_response(response)
      return response if [200, 201].include?(response.code)
      raise "NuOrder API Error #{response.code}. #{response["message"]}"
    end

    def get_oauth_headers(method, url, addons = nil)
      time = Time.now.to_i
      nonce = SecureRandom.hex(8)
      signature = build_signature(method, url, time, nonce, addons)
      {
        'Authorization' => "oAuth #{build_oauth(time, nonce, signature, addons)}",
        'Accept' => 'application/json',
        'Content-Type' => 'application/json'
      }
    end

    def build_signature(method, url, time, nonce, addons)
      base = "#{method}#{endpoint}#{url}?"
      base << "oauth_consumer_key=#{oauth_consumer_key}"
      base << "&oauth_token=#{oauth_token}"
      base << "&oauth_timestamp=#{time}"
      base << "&oauth_nonce=#{nonce}"
      base << "&oauth_version=1.0&oauth_signature_method=HMAC-SHA1"
      base << "&oauth_verifier=#{addons['oauth_verifier']}" if addons && addons.include?('oauth_verifier')
      base << "&oauth_callback=#{addons['oauth_callback']}" if addons && addons.include?('oauth_callback')
      key = [oauth_consumer_secret, oauth_token_secret].join('&')
      digest = OpenSSL::Digest.new('sha1')
      OpenSSL::HMAC.hexdigest(digest, key, base)
    end

    def build_oauth(time, nonce, signature, addons)
      oauth = {
        'oauth_consumer_key' => @oauth_consumer_key,
        'oauth_timestamp' => time,
        'oauth_nonce' => nonce,
        'oauth_version' => '1.0',
        'oauth_signature_method' => 'HMAC-SHA1',
        'oauth_token' => @oauth_token,
        'oauth_signature' => signature
      }
      oauth.merge!(addons) unless addons.nil?
      oauth.map { |k,v| "#{k}=#{v}" }.join(',')
    end
  end
end
