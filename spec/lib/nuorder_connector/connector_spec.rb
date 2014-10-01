require 'spec_helper'

describe NuOrderConnector::Connector do
  include_examples 'config hash'
  subject { described_class.new(
    consumer_key: config['nuorder_consumer_key'],
    consumer_secret: config['nuorder_consumer_secret'],
    oauth_token: config['nuorder_token'],
    oauth_token_secret: config['nuorder_token_secret'],
    endpoint: config['endpoint']
  )}

  [:api_initiate, :get_oauth_token, :get, :post].each do |method|
    it { should respond_to(method) }
  end

  describe '#api_initiate' do
    it 'returns temp oauth_token and oauth_token_secret from API' do
      VCR.use_cassette "connector/api_initiate" do
        subject.api_initiate
        expect(subject.oauth_token).not_to be_nil
        expect(subject.oauth_token_secret).not_to be_nil
      end
    end
  end

  describe '#get_oauth_token' do
    before do
      subject.oauth_verifier = 'xaFZ4r2GMSDY7jeW'
      subject.oauth_token = 'ZfhRqA5aDQfqTHPJ'
      subject.oauth_token_secret = '5E4HQZbWt5aSRJyaPhgDYSu2'
    end

    it 'returns real oauth_token and oauth_token_secret from API' do
      VCR.use_cassette "connector/get_oauth_token" do
        subject.get_oauth_token
        expect(subject.oauth_token).not_to be_nil
        expect(subject.oauth_token_secret).not_to be_nil
      end
    end

    it 'raises error if theres no oauth_verifier' do
      subject.oauth_verifier = nil
      expect{ subject.get_oauth_token }.to raise_error('No oauth_verifier')
    end
  end

  describe '#get' do
    it 'raises error if NuOrder api returns error' do
      VCR.use_cassette 'connector/get2' do
        expect { subject.get("/api/product/541204aca01ceed9650486a2") }.to raise_error
      end
    end
  end

  describe '#post' do
    it 'raises error if NuOrder api returns error' do
      VCR.use_cassette 'connector/post' do
        expect { subject.post("/api/company/new") }.to raise_error
      end
    end
  end
end
