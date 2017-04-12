class Currency < ApplicationRecord
  include Concerns::Polymorphic::Helpers
  
  before_update :set_last_transmutation_date, lambda { set_last_transmutation_amount(value - value_was) }, if: :value_changed?

  belongs_to :cashable, polymorphic: true

  protected
  
    def set_last_transmutation_amount(amount)
        self.last_transmutation_amount = amount
    end
    
    def set_last_transmutation_date(date = DateTime.now)
        self.last_transmutation_date = date
    end

end
