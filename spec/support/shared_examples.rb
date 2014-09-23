test_config_hash = {
  nuorder_consumer_key: 'mduVpZauWaTZTjg64UQd3DRX',
  nuorder_consumer_secret: 'gqRWTrrPJrEtwEUWmBcE9atwZr7Y8Kdxjras3DVAzrvqWRhkVme2JaR4VDq64c9c',
  nuorder_token: 'F4bf5URBG5fAvHmKegPZW5ZY',
  nuorder_token_secret: 'M4ZQU3bruFcCnPya2fVcP6jtykMsXQCH6bSvxKy3jQ4syeT6AASmB83RHUS47vV7',
  endpoint: 'http://sandbox1.nuorder.com'
}.with_indifferent_access

shared_examples "config hash" do
  let(:config) { test_config_hash }
end

