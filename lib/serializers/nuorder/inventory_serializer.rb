module NuOrder
  class InventorySerializer
    def self.serialize(nuorder_inventory)
      output = {}
      [:prebook, :warehouse].each do |attribute|
        output[attribute] = nuorder_inventory.send(attribute)
      end
      output[:wip] = nuorder_inventory.wip.map do |wip|
        {
          name: wip.name,
          sizes: wip.sizes.map { |size| size.attributes }
        }
      end
      {inventory: [output]}
    end
  end
end
