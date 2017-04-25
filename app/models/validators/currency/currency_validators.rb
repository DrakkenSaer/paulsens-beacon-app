module Validators::Currency
    currency_types = Currency.distinct.pluck(:type)
    currency_types.each do |currency|
        currency_name = currency.downcase.pluralize
        define_method("has_enough_#{currency_name}?") do |record, object = self|
            object.respond_to?(currency_name) &&
            record.respond_to?(:total_cost) &&
            object.send(currency_name).present? &&
            (object.send(currency_name).value - record.total_cost) >= 0
        end
    end
end