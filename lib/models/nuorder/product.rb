module NuOrder
  class Product
    class Pricing
      include Virtus.value_object(strict: true)

      # This field does not reflect real api structure, must be serialized
      # as property one level up
      attribute :currency, String
      # The wholesale price in the given currency. Setting this to 0 will
      # disable the product within this currency.
      attribute :wholesale, Integer
      # The retail price in the given currency.
      attribute :retail, Integer
    end

    class Size
      include Virtus.value_object(strict: true)

      # The name of the size.
      attribute :size, String
      # The upc for this size. The UPC is only required if the brand is set to
      # utilize UPCs. In the case where a UPC is required but is not available,
      # “N/A” or a similar value can be sent instead.
      attribute :upc, String
      # This follows the same data structure as “pricing” on the root level of
      # the product.
      attribute :pricing, Array[Pricing]
    end

    include Virtus.value_object(strict: true)

    attribute :_id, String
    attribute :created_on, String
    attribute :modified_on, String
    # The external id.
    attribute :brand_id, String, strict: false
    # The name of this product.
    attribute :name, String
    # The style number.
    attribute :style, String
    # The name of the color.
    attribute :color, String
    # The code for the given color.
    attribute :color_code, String
    # The name of the primary season.
    attribute :season, String
    # The name of the department.
    attribute :department, String
    # The name of the division.
    attribute :division, String
    # The name of the subcategory.
    attribute :category, String
    # The date this product is available to order.
    attribute :available_from, Date
    # The date this product is available to order until.
    attribute :available_until, Date
    # The date orders are no longer accepted.
    attribute :order_closing, Date

    # This field is required at the root level for brands that do not utilize
    # unique pricing per size. It is required at the size level for brands
    # that do utilize this feature.
    attribute :pricing, Array[Pricing]

    # The sizes available for this product, in the order they will be
    # displayed on NuORDER.
    attribute :sizes, Array[Size]
  end
end
