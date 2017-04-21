class HasEnoughPointsValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, user)
        unless (user.points.value - record.total_cost) > 0
            record.errors[attribute] << (options[:message] || "does not have enough points")
        end
    end
end