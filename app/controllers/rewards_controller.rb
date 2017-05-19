class RewardsController < ApplicationController
  include Concerns::Resource::State::ResourceStateChange

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
    @reward = Reward.new(reward_params)
    authorize_reward

    respond_to do |format|
      if @reward.save
        format.html { redirect_to @reward, notice: 'Reward was successfully created.' }
        format.json { render :show, status: :created, location: @reward }
      else
        format.html { render :new }
        format.json { render json: @reward.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @reward.update(reward_params)
        format.html { redirect_to @reward, notice: 'Reward was successfully updated.' }
        format.json { render :show, status: :ok, location: @reward }
      else
        format.html { render :edit }
        format.json { render json: @reward.errors, status: :unprocessable_entity }
      end
    end
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
