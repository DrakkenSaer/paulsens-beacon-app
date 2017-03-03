class PromotionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_promotion, except: [:index, :create]
  before_action :authorize_promotion, except: [:index, :create]

  # GET /promotions
  # GET /promotions.json
  def index
    @promotions = policy_scope(Promotion)
  end

  # GET /promotions/1
  # GET /promotions/1.json
  def show
  end

  # GET /promotions/new
  def new
  end
  
  # GET /promotions/1/edit
  def edit
  end

  # POST /promotions
  # POST /promotions.json
  def create
    @promotion = Promotion.new(promotion_params)
    authorize_promotion
    
    respond_to do |format|
      if @promotion.save
        format.html { redirect_to @promotion, success: "Promotion successfully created!" }
        format.json { render :show, status: :created, location: @promotion }
      else
        format.html { ender :new }
        format.json { render json: @promotion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /promotions/1
  # PATCH/PUT /promotions/1.json
  def update
    respond_to do |format|
      if @promotion.update(promotion_params)
        format.html { redirect_to @promotion, success: "Promotion successfully updated!" }
        format.json { render :show, status: :ok, location: @promotion }
      else
        format.html { render :edit }
        format.json { render json: @promotion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /promotions/1
  # DELETE /promotions/1.json
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
                                        :expiration)
    end
    
    def set_promotion
      @promotion = params[:id] ? Promotion.find(params[:id]) : Promotion.new
    end
    
    def authorize_promotion
      authorize @promotion
    end
end
