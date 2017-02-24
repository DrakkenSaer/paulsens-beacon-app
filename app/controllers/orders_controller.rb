class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order, except: [:index, :create]
  before_action :authorize_order, except: [:index, :create]

  def index
    @orders = policy_scope(Order)
  end

  def show
  end

  def new
  end

  def create
    @order = Order.new(order_params)
    
    authorize_order

    if @order.save
      redirect_to @order, success: "Order successfully created!"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @order.update(order_params)
      redirect_to @order, success: "Order successfully updated!"
    else
      render :edit
    end
  end

  def destroy
    @order.destroy
    redirect_to orders_url, success: "Order successfully deleted!"
  end
  
  private 
  
    def order_params
      params.require(:order).permit(:user_id, promotionals_attributes: [:id])
    end
    
    def set_order
      @order = params[:id] ? Order.find(params[:id]) : Order.new
    end
    
    def authorize_order
       authorize(@order)
    end

end
