module Concerns::Purchasable
    def purchase!(user = self, item)
        resource_type = item.class.name.downcase.pluralize
        
        begin
            order = user.orders.new
            order.send(resource_type) << item
            order.save!
        rescue => e
            logger.error(e.message)
        end
    end
end