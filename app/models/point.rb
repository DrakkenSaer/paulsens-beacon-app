class Point < Currency
    before_validation :set_default_value

    validates :value, presence: true
    validate :validate_incrementation_limit, if: :value_changed?

    protected
    
        def set_default_value
            self.value ||= 0 if self.has_attribute? :value
        end
        
        def validate_incrementation_limit
            if last_transmutation_date.today? && last_transmutation_amount > 0 && (value - value_was) > 0
                errors.add(:value, "cannot be incremented any further today")
            end unless last_transmutation_date.nil? || last_transmutation_amount.nil?
        end

end
