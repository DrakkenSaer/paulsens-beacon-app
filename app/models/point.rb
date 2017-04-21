class Point < Currency

  validate :validate_incrementation_limit, if: :value_changed?

  protected

  def validate_incrementation_limit
    if last_transmutation_date.today? && last_transmutation_amount > 0 && (value - value_was) > 0
      errors.add(:value, "cannot be incremented any further today")
    end unless last_transmutation_date.nil? || last_transmutation_amount.nil?
  end

end
