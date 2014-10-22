test_config_hash = {
  nuorder_consumer_key: ENV['NUORDER_CONSUMER_KEY'],
  nuorder_consumer_secret: ENV['NUORDER_CONSUMER_SECRET'],
  nuorder_token: ENV['NUORDER_TOKEN'],
  nuorder_token_secret: ENV['NUORDER_TOKEN_SECRET'],
  endpoint: 'http://sandbox1.nuorder.com'
}.with_indifferent_access

shared_examples "config hash" do
  let(:config) { test_config_hash }
end

