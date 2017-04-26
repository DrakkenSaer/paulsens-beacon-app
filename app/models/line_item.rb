class LineItem < ApplicationRecord
  include Concerns::Polymorphic::Helpers
  include Helpers::ResourceStateHelper

  before_validation :set_default_item_cost
  
  belongs_to :lineable, polymorphic: true
  belongs_to :order, inverse_of: :line_items

  validates :item_cost, presence: true

  include AASM
  STATES = [:pending, :activated, :redeemed]
  aasm :column => 'resource_state', :with_klass => PaulsensAASMBase do
    require_state_methods!

    before_all_events :set_state_user

    STATES.each do |status|
      state(status, initial: STATES[0] == status)
    end

    event :redeem do
      transitions from: STATES, to: :redeemed, success: :set_redeemed_date!
    end
  end

  protected

    def set_default_item_cost
      self.item_cost = self.send(resourcable_type_name).constantize.find( self.send(resourcable_id_name) ).cost if self.item_cost.nil?
    end

    def set_redeemed_date!(date = DateTime.now)
      self.update!(redeemed_date: date)
    end

end
