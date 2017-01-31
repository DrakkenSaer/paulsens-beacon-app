class PromotionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_promotion, except: [:index, :create]

  def index
    @promotions = policy_scope(Promotion)
  end

  def show
  end

  def new
  end

  def create
    @promotion = Promotion.new(promotion_params)
    if @promotion.save
      redirect_to @promotion, success: "Promotion successfully created!"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @promotion.update(promotion_params)
      redirect_to @promotion, success: "Promotion successfully updated!"
    else
      render :edit
    end
  end

  def destroy
    @promotion.destroy
    redirect_to promotions_url
  end
  
private
  def promotion_params
    params.require(:promotion).permit(:promotional_id, :promotional_type, :title, :description, :code, :redeem_count, :daily_deal, :featured, :cost, :expiration)
  end
  
  def set_promotion
    @promotion = Promotion.find(params[:id])
  end
end
