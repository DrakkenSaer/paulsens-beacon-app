class PromotionsController < ApplicationController
  respond_to :html, :json

  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_promotion, except: [:index, :create]
  before_action :authorize_promotion, except: [:index, :create]

  def index
    @promotions = policy_scope(Promotion)
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    @promotion = Promotion.create(promotion_params)
    authorize_promotion
    respond_with @promotion
  end

  def update
    @promotion.update(promotion_params)
    respond_with @promotion
  end

  def destroy
    @promotion.destroy
    respond_to do |format|
      format.html { redirect_to promotions_url, notice: "Promotion was successfully deleted" }
      format.json { head :no_content }
    end
  end

  private

    def promotion_params
      params.require(:promotion).permit(:promotional_id,
                                        :promotional_type,
                                        :title,
                                        :description,
                                        :code,
                                        :redeem_count,
                                        :daily_deal,
                                        :featured,
                                        :cost,
                                        :expiration,
                                        :image)
    end
  
    def set_promotion
      @promotion = params[:id] ? Promotion.find(params[:id]) : Promotion.new
    end
  
    def authorize_promotion
      authorize @promotion
    end

end
