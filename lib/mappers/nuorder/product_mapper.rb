module NuOrder
  class ProductMapper
    def initialize(wombat_product)
      @wombat_product = wombat_product.dup.freeze
    end

    def build
      @product ||= NuOrder::Product.new(
        {
          name: @wombat_product['name'],
          style_number: 'style number',
          color: 'color',
          season: 'season',
          department: 'department',
          available_from: @wombat_product['available_on'],
          pricing: [pricing(@wombat_product)],
          sizes: sizes
        }.compact
      )
    end

    private

    def pricing(product, currency = 'USD')
      NuOrder::Product::Pricing.new(
        currency: currency,
        wholesale: product['price'],
        retail: product['cost_price']
      )
    end

    def sizes
      @sizes ||= [
        NuOrder::Product::Size.new(
          size: 'default',
          upc: @wombat_product['sku'],
          pricing: pricing(@wombat_product)
        ),
        @wombat_product['variants'].try(:map) do |variant|
          NuOrder::Product::Size.new(
            size: variant.fetch('options', {})['size'],
            upc: variant['sku'],
            pricing: [pricing(variant)]
          )
        end
      ].flatten.compact
    end
  end
end

