class Order < ApplicationRecord
    require 'validators/points/has_enough_points_validator'
  
    include Helpers::ResourceStateHelper
    include Helpers::ResourceRecordHelper

    belongs_to :user
    has_many :line_items, dependent: :destroy, inverse_of: :order
    has_many :products, through: :line_items, source: :orderable, source_type: 'Product'
    has_many :promotions, through: :line_items, source: :orderable, source_type: 'Promotion'
    
    accepts_nested_attributes_for :products, :promotions, reject_if: :all_blank

    resourcify
    
    validates :user, has_enough_points: true, if: lambda { transitioning_to_state?(:complete) }

    include AASM
    STATES = [:pending, :activated, :completed, :canceled]
    aasm :column => 'resource_state', :with_klass => PaulsensAASMBase do
        require_state_methods!

        before_all_events :set_state_user
        
        STATES.map do |status|
            state(status, initial: STATES[0] == status)
        end

        event :complete, guards: lambda { @user.has_enough_points?(self) } do
            transitions from: STATES, to: :completed, success: [lambda { user.points.spend!(total_cost) }, :set_completion_date!]
        end

        event :cancel do
            transitions from: STATES, to: :canceled
        end
    end

    # This is temporary, waiting to think of a better solution. Do not test.
    def promotions_attributes=(promotions_attributes)
        promotions_attributes.each do |key, promotion_attributes|
            line_items.build(orderable_type: 'Promotion', orderable_id: promotions_attributes[key][:id], cost: promotions_attributes[key][:cost])
        end
    end
    
    # Tallies up the cost of each LineItem rounded to the second decimal place
    def total_cost
        cost_array = line_items.map(&:cost)
        sum_of_cost_array = cost_array.present? ? cost_array.inject(:+) : 0
        sum_of_cost_array.round(2)
    end

    protected

        def set_completion_date!(date = DateTime.now)
           self.update!(completion_date: date)
        end

end
