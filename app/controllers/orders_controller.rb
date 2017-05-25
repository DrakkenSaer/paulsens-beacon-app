class OrdersController < ApplicationController
  include Concerns::Resource::State::ResourceStateChange

  respond_to :html, :json

  before_action :authenticate_user!
  before_action :set_order, except: [:index, :create]
  before_action :authorize_order, except: [:index, :create]
  before_action :set_form_resources, except: [:index, :show, :destroy]

  def index
    @orders = policy_scope(Order)
  end

  def show
  end

  def new
  end

  def create
    @order = Order.create(order_params)
    authorize_order
    @order.complete!(@order.user) if @order.persisted?
    respond_with @order
  end

  def edit
  end

  def update
    @order.update(order_params)
    respond_with @order
  end

  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  private 
  
    def order_params
      params.require(:order).permit(:user_id, promotions_attributes: [:id, :cost])
    end

    def set_order
      @order = params[:id] ? Order.find(params[:id]) : Order.new
    end

    def set_form_resources
      @users = User.all
      @products = Product.all
    end

    def authorize_order
       authorize(@order)
    end

end