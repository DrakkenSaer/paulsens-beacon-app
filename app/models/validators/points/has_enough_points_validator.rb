class HasEnoughPointsValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, object)
        unless object.respond_to?(:points) && (object.points.value - record.total_cost) >= 0
            record.errors[attribute] << (options[:message] || "does not have enough points")
        end
    end
end