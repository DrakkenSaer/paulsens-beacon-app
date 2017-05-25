class ProductsController < ApplicationController
  respond_to :html, :json
  
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_product, except: [:index, :create]
  before_action :authorize_product, except: [:index, :create]
  before_action :set_form_resources, except: [:index, :show, :destroy]

  def index
    @products = policy_scope(Product)
  end

  def show
  end

  def new
  end

  def create
    @product = Product.create(product_params)
    authorize_product
    respond_with @product
  end

  def edit
  end

  def update
    @product.update_attributes(product_params)
    respond_with @product
  end

  def destroy
    @product.destroy

    respond_to do |format|
      format.html { redirect_to products_url, notice: "Product successfully destroyed" }
      format.json { head :no_content }
    end
  end

  private

    def product_params
      params.require(:product).permit(:featured,
                                      :cost,
                                      :title,
                                      :description,
                                      :image,
                                      promotions_attributes: [:id, :_destroy])
    end

    def set_product
      @product = params[:id] ? Product.find(params[:id]) : Product.new
    end

    def authorize_product
      authorize(@product)
    end

    def set_form_resources
      @promotions = policy_scope(Promotion)
    end

end
