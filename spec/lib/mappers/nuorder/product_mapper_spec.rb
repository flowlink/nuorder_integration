require 'spec_helper'

describe NuOrder::ProductMapper do
  subject { described_class }
  let(:wombat_product) do
    JSON.parse(
      IO.read(File.join(App.root, 'spec/support/fixtures/wombat_product.json'))
    )['product']
  end

  it 'parses valid product successfully' do
    expect { subject.new(wombat_product).build }.to_not raise_error
  end
end

