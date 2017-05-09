module Validators::Currency
    currency_types = Currency.distinct.pluck(:type)
    currency_types.each do |currency|
        currency_name = currency.downcase.pluralize
        define_method("has_enough_#{currency_name}?") do |total_cost, object = self|
            object.respond_to?(currency_name) &&
            object.send(currency_name).present? &&
            (object.send(currency_name).value - total_cost) >= 0
        end
    end
end