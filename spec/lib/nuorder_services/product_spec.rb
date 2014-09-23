require 'spec_helper'

describe NuOrderServices::Product do
  include_examples 'config hash'
  subject { described_class.new(config) }

  describe '#find' do
    it 'returns nuorder product data for given id' do
      VCR.use_cassette('nuorder_product_find') do
        response = subject.find('541aa3f054f4a1d81aa878dd')
        expect(response['_id']).to eq '541aa3f054f4a1d81aa878dd'
      end
    end
  end
end
