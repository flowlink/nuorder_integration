require 'rubygems'
require 'bundler'
require 'pry'
ENV['APP_ENV'] = 'test'
ENV['ENDPOINT_KEY'] = '123'
Bundler.require(:default, :test)
Dotenv.load

require File.join(File.dirname(__FILE__), '..', 'config/environment')
require File.join(File.dirname(__FILE__), '..', 'nuorder_endpoint')
require 'nuorder_integration'

Dir['./spec/support/**/*.rb'].each { |f| require f }
require 'spree/testing_support/controllers'

Sinatra::Base.environment = 'test'

VCR.configure do |config|
  config.allow_http_connections_when_no_cassette = true
  config.cassette_library_dir = 'spec/cassettes'
  config.hook_into :webmock

  config.filter_sensitive_data('spree_cons_key')    { |_| ENV['NUORDER_CONSUMER_KEY'] }
  config.filter_sensitive_data('spree_cons_secret') { |_| ENV['NUORDER_CONSUMER_SECRET'] }
  config.filter_sensitive_data('spree_token')       { |_| ENV['NUORDER_TOKEN'] }
  config.filter_sensitive_data('spree_secret')      { |_| ENV['NUORDER_TOKEN_SECRET'] }
end

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.include Spree::TestingSupport::Controllers
end
