module NuOrder
  class InventoryMapper
    def initialize(wombat_inventory)
      @wombat_inventory = wombat_inventory.dup.freeze
    end

    def build
      @inventory ||= NuOrder::Inventory.new(
        warehouse: 'default',
        prebook: false,
        wip: build_wip
      )
    end

    private

    def build_wip
      @wip ||= [
        NuOrder::Inventory::Wip.new(
          name: 'immediate',
          sizes: [
            NuOrder::Inventory::Wip::Size.new(
              size: 'default',
              quantity: @wombat_inventory['quantity']
            )
          ]
        )
      ]
    end
  end
end
