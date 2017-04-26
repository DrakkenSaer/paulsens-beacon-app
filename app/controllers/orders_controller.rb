class OrdersController < ApplicationController
  include Concerns::Resource::State::ResourceStateChange

  before_action :authenticate_user!
  before_action :set_order, except: [:index, :create]
  before_action :authorize_order, except: [:index, :create]
  before_action :set_form_resources, only: [:new, :edit]

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

    respond_to do |format|
      if @order.save
        @order.complete!
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order, json: @order.user.to_json }
      else
        set_form_resources
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    if @order.update(order_params)
      redirect_to @order, success: "Order successfully updated!"
    else
      set_form_resources
      render :edit
    end
  end

  def destroy
    @order.destroy
    redirect_to orders_url, success: "Order successfully deleted!"
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