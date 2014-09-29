module NuOrder
  class Inventory
    class Wip
      class Size
        include Virtus.value_object(strict: true)

        # The name of the size.
        attribute :size, String
        # The quantity on hand/on order for this warehouse/wip delivery/size
        # combination.
        attribute :quantity, Integer
      end

      include Virtus.value_object(strict: true)

      # The name of the WIP delivery.
      attribute :name, String
      attribute :sizes, Array[Size]
    end

    include Virtus.value_object(strict: true)

    # The warehouse name or code
    attribute :warehouse, String
    # Are pre-book orders currently accepted for this product?
    attribute :prebook, Boolean, strict: false
    # The WIP deliveries that are available for this product in this warehouse.
    attribute :wip, Array[Wip], strict: false
  end
end
