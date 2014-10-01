module NuOrder
  class ProductSerializer
    def self.serialize(nuorder_product)
      output = {}
      [
        :brand_id, :name, :style, :color, :color_code,
        :season, :department, :division, :category,
        :available_from, :available_until, :order_closing
      ].each do |attribute|
        output[attribute] = nuorder_product.public_send(attribute)
      end

      output[:pricing] = serialize_pricings(nuorder_product.pricing)

      output[:sizes] = nuorder_product.sizes.map do |size|
        {
          size: size.size,
          upc: size.upc,
          pricing: serialize_pricings(size.pricing)
        }
      end

      output.compact
    end

    private

    def self.serialize_pricings(pricings)
      output = {}
      pricings.each do |pricing|
        output[pricing.currency] = {
          wholesale:    pricing.wholesale,
          retail:       pricing.retail
        }
      end
      output
    end
  end
end
