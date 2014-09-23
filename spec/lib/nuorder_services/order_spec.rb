require 'spec_helper'

describe NuOrderServices::Order do
  include_examples 'config hash'
  subject { described_class.new(config) }

  describe '#all' do
    it 'returns all orders with given status' do
      VCR.use_cassette('nuorder_order_all') do
        response = subject.all('pending')
        expect(response).not_to be_nil
      end
    end

    it 'returns all orders with different status' do
      VCR.use_cassette('nuorder_order_all2') do
        response = subject.all(['pending', 'edited', 'approved'])
        expect(response.size).to eq 2
      end
    end
  end

  describe '#process!' do
    it 'calls proper api endpoint' do
      VCR.use_cassette('nuorder_order_process') do
        response = subject.process!('541c279e663e94c8129f46d3')
        expect(response.response.code).to eq '200'
      end
    end

    it 'changes order status to processed' do
      VCR.use_cassette('nuorder_order_process') do
        response = subject.process!('541c279e663e94c8129f46d3')
        expect(response['status']).to eq 'processed'
      end
    end
  end

  describe '#cancel!' do
    it 'calls proper api endpoint' do
      VCR.use_cassette('nuorder_order_cancel') do
        response = subject.cancel!('541c279e663e94c8129f46d3')
        expect(response.response.code).to eq '200'
      end
    end

    it 'changes order status to cancelled' do
      VCR.use_cassette('nuorder_order_cancel') do
        response = subject.cancel!('541c279e663e94c8129f46d3')
        expect(response['status']).to eq 'cancelled'
      end
    end
  end
end
