require 'spec_helper'

describe Wombat::OrderBuilder do
  include_examples 'config hash'
  subject { described_class }
  let(:order_service) { NuOrderServices::Order.new(config) }

  it 'parses valid order successfully' do
    VCR.use_cassette('nuorder_order_all') do
      response = order_service.all('pending')
      response.each do |order|
        expect { Wombat::OrderBuilder.new(order).build }.to_not raise_error
      end
    end
  end
end
