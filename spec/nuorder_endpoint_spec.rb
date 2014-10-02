require 'spec_helper'

describe NuorderEndpoint do
  include_examples 'config hash'

  context 'webhooks' do
    ['get_orders', 'cancel_order', 'add_product'].each do |path|
      describe path do
        let(:payload) do
          payload = Factories.send("#{path}_payload")
          payload.merge(parameters: config)
        end

        it 'works' do
          VCR.use_cassette "requests/#{path}" do
            post "/#{path}", payload.to_json, auth
            expect(last_response).to be_ok
            body = JSON.parse(last_response.body)
            expect(body['request_id']).to eq payload['request_id']
          end
        end
      end
    end
  end

  context 'additional webhook specs' do
    describe 'add_product' do
      let(:payload) do
        payload = Factories.send('add_product_payload')
        payload.merge(parameters: config)
      end

      it 'returns new object id to wombat' do
        VCR.use_cassette 'requests/add_product' do
          post '/add_product', payload.to_json, auth
          body = JSON.parse(last_response.body)
          expect(body['products']).to eq([{ 'id' => payload['product']['id'], 'nuorder_id' => '542d177c9037859676643bd7' }])
        end
      end
    end
  end
end
