class OrdersController < ResourceController
  include Concerns::Resource::State::ResourceStateChange

  before_action :authenticate_user!
  before_action :set_form_resources, except: [:index, :show, :destroy]

  def create
    @order = Order.create(order_params)
    authorize_order
    @order.complete!(@order.user) if @order.persisted?
    respond_with @order
  end


  private 
  
    def order_params
      params.require(:order).permit(:user_id, promotions_attributes: [:id, :cost])
    end

    def authorize_order
       authorize(@order)
    end

end