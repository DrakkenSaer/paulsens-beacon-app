class HasEnoughCreditValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, object)
        unless object.has_enough_credits?(record.total_cost)
            record.errors[attribute] << (options[:message] || "does not have enough credit")
        end
    end
end