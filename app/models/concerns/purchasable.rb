module Concerns::Purchasable
    def purchase!(item = self, user)
        resource_type = item.class.name.downcase.pluralize

        order = user.orders.new
        order.send(resource_type) << item
        order.save!
    end
end