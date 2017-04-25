class HasEnoughPointsValidator < ActiveModel::EachValidator
    include Validators::Currency  

    def validate_each(record, attribute, object)
        unless object.has_enough_points?(record)
            record.errors[attribute] << (options[:message] || "does not have enough points")
        end
    end
end