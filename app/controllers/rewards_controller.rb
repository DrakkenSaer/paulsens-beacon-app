class RewardsController < ResourceController
  include Concerns::Resource::State::ResourceStateChange

  before_action :authenticate_user!
  before_action :set_form_resources, only: [:new, :edit]

  private

    def set_form_resources
      @users = User.all
      @rewards = Product.all + Promotion.all
    end

    def reward_params
      params.require(:reward).permit(:rewardable_id, :rewardable_type, :user_id)
    end

end
