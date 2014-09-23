module NuOrderServices
  class Product < Base
    def find(id)
      nuorder.get("/api/product/#{id}")
    end
  end
end
