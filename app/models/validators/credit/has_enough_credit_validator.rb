class HasEnoughCreditValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, object)
        unless object.credit.can_spend?(record.total_cost)
            record.errors[attribute] << (options[:message] || "does not have enough credit")
        end
    end
end