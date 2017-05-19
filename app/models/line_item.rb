class LineItem < ApplicationRecord
  include Concerns::Polymorphic::Helpers
  include Helpers::ResourceStateHelper

  before_validation :set_default_cost

  belongs_to :orderable, polymorphic: true
  belongs_to :order, inverse_of: :line_items

  validates :cost, presence: true

  include AASM
  STATES = [:pending]
  aasm :column => 'resource_state', :with_klass => PaulsensAASMBase do
    require_state_methods!

    before_all_events :set_state_user

    STATES.map do |status|
      state(status, initial: STATES[0] == status)
    end
  end

  protected

    def set_default_cost
      self.cost = polymorphic_resource.cost if self.cost.nil?
    end

end
