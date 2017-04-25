module Concerns::Purchasable
    def purchase!(item = self, user = current_user)
        resource_type = item.class.name.downcase.pluralize
        order = user.orders.new
        order.send(resource_type) << item
        order.save!
    rescue => e
        logger.error(e.message)
    end
end