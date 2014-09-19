require 'rubygems'
require 'bundler'
require 'pry'
ENV['APP_ENV'] = 'test'
Bundler.require(:default, :test)

require File.join(File.dirname(__FILE__), '..', 'config/environment')
require File.join(File.dirname(__FILE__), '..', 'nuorder_endpoint')

Dir['./spec/support/**/*.rb'].each { |f| require f }
require 'spree/testing_support/controllers'

Sinatra::Base.environment = 'test'

VCR.configure do |config|
  config.allow_http_connections_when_no_cassette = true
  config.casette_library_dir = 'spec/cassettes'
  config.hook_into :webmock
end

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.include Spree::TestingSupport::Controllers
end
