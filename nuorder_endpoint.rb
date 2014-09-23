require 'sinatra'
require 'sinatra/reloader' if development?
require 'endpoint_base'
require 'nuorder_integration'

class NuorderEndpoint < EndpointBase::Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end
  enable :logging

  get '/get_orders' do
    'NotImplemented'
  end

  post '/cancel_order' do
    begin
      NuOrderServices::Order.new(@config).cancel!(@payload[:nuorder_id])
      set_summary "Order has been cancelled in NuOrder"
      result 200
    rescue Exception => e
      log_exception(e)
      result 500, e.message
    end
  end
end

