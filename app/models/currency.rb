class Currency < ApplicationRecord
  include Concerns::Polymorphic::Helpers

  before_validation :set_default_value
  before_update :set_last_transmutation_date, lambda { set_last_transmutation_amount(value - value_was) }, if: :value_changed?

  belongs_to :cashable, polymorphic: true
   
  validates :value, presence: true, numericality: { greater_than_or_equal_to: 0 }

  def spend!(value)
    raise ArgumentError, 'Argument is not positive' unless value >= 0
    self.update!(value: self.value - value)
  end

  protected

    def set_default_value
        self.value ||= 0 if self.has_attribute? :value
    end
  
    def set_last_transmutation_amount(amount)
        self.last_transmutation_amount = amount
    end
    
    def set_last_transmutation_date(date = DateTime.now)
        self.last_transmutation_date = date
    end

end
