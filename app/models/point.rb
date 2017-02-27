class Point < Currency
    before_validation :set_default_value 

    validates :value, presence: true

    protected
    
        def set_default_value
            self.value ||= '0.0' if self.has_attribute? :value
        end

end
