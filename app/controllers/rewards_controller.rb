class RewardsController < ApplicationController
  include Concerns::Resource::State::ResourceStateChange
  
  respond_to :html, :json

  before_action :authenticate_user!
  before_action :set_reward, except: [:index, :create]
  before_action :authorize_reward, except: [:index, :create]
  before_action :set_form_resources, only: [:new, :edit]

  def index
    @rewards = policy_scope(Reward)
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    @reward = Reward.create(reward_params)
    authorize_reward
    respond_with @reward
  end

  def update
    @reward.update(reward_params)
    respond_with @reward
  end

  def destroy
    @reward.destroy
    respond_to do |format|
      format.html { redirect_to rewards_url, notice: 'Reward was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_reward
      @reward = params[:id] ? Reward.find(params[:id]) : Reward.new
    end

    def authorize_reward
       authorize(@reward)
    end

    def set_form_resources
      @users = User.all
      @rewards = Product.all + Promotion.all
    end

    def reward_params
      params.require(:reward).permit(:rewardable_id, :rewardable_type, :user_id)
    end

end
