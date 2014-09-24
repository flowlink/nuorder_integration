module NuOrderServices
  class Order < Base

    def all(options)
      options = [*options]
      results = []
      options.each do |status|
        results << nuorder.get("/api/orders/#{status}/detail")
      end
      results.flatten
    end

    def process!(ids)
      ids = [*ids]
      results = []
      ids.each do |id|
        results << nuorder.post("/api/order/#{id}/process")
      end
      results.flatten
    end

    def cancel!(id)
      nuorder.post("/api/order/#{id}/cancel")
    end
  end
end
