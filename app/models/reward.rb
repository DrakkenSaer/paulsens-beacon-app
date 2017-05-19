class Reward < ApplicationRecord
  belongs_to :user
  belongs_to :rewardable

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

    def set_redeemed_date!(date = DateTime.now)
      self.update!(redeemed_date: date)
    end

end
