require 'sinatra'
require "sinatra/reloader" if development?
require 'endpoint_base'

class NuorderEndpoint < EndpointBase::Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end
  enable :logging

  get '/get_orders' do
    'NotImplemented'
  end
end
