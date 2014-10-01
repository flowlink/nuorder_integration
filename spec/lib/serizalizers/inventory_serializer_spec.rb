require 'spec_helper'

describe Wombat::InventorySerizalizer do
  it 'successfully serializes inventory' do
    attributes = {
      id: 'qbs-SPR-00011',
      product_id: 'SPR-00011',
      nuorder_id: '3030',
      quantity: 0,
      location: 'location'
    }
    wombat_inventory = Wombat::Inventory.new(attributes)

    expect(described_class.serialize(wombat_inventory)).to eq attributes
  end
end
