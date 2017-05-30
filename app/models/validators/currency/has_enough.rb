module Validators::Currency::HasEnough
    def self.invoke(source)
        define_class_methods(source)
    end

    # Performance hit: Avoids falseClass empty stop along the call chain - https://8thlight.com/blog/josh-cheek/2012/02/03/modules-called-they-want-their-integrity-back.html
    def define_class_methods(source = self)
        class << source
            currency_types = Currency.distinct.pluck(:type) || ['Credit']
            currency_types.map do |currency|
                currency_name = currency.downcase.pluralize
                define_method("has_enough_#{currency_name}?") do |total_cost, object = self|
                    object.respond_to?(currency_name) &&
                    object.send(currency_name).present? &&
                    (object.send(currency_name).value - total_cost) >= 0
                end
            end
        end
    end

    extend self
end