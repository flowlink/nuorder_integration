module NuOrderServices
  class Order < Base
    def all(status = 'pending')
      nuorder.get("/api/orders/#{status}/detail")
    end

    def process!(id)
      nuorder.post("/api/order/#{id}/process")
    end

    def cancel!(id)
      nuorder.post("/api/order/#{id}/cancel")
    end
  end
end
