module NuOrderServices
  class Order < Base

    def all(options)
      if options.is_a? String
        nuorder.get("/api/orders/#{options}/detail")
      elsif options.is_a? Array
        results = []
        options.each do |status|
          results << nuorder.get("/api/orders/#{status}/detail")
        end
        results.flatten
      end
    end

    def process!(id)
      nuorder.post("/api/order/#{id}/process")
    end

    def cancel!(id)
      nuorder.post("/api/order/#{id}/cancel")
    end
  end
end
