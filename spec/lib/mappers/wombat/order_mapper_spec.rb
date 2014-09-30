require 'spec_helper'

describe Wombat::OrderMapper do
  include_examples 'config hash'
  subject { described_class }
  let(:order_service) { NuOrderServices::Order.new(config) }

  it 'parses valid order successfully' do
    VCR.use_cassette('nuorder_order_all') do
      response = order_service.all('pending')
      response.each do |order|
        expect { subject.new(order).build }.to_not raise_error
      end
    end
  end

  it 'does not parse invalid order' do
    VCR.use_cassette('nuorder_order_all') do
      response = order_service.all('pending')
      response.each do |order|
        invalid_order = order.delete(:_id)
        expect { subject.new(invalid_order).build }.to raise_error
      end
    end
  end
end
