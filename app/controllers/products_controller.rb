class ProductsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_product, except: [:index, :create]
  before_action :authorize_product, except: [:index, :create]

  def index
    @products = policy_scope(Product)
  end

  def show
  end

  def new
  end

  def create
    @product = Product.new(product_params)
    
    authorize_product

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, success: 'Product was successfully created.' }
        format.json { render json: @product, status: :created, location: @product }
      else
        format.html { render action: :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @product.update_attributes(product_params)
       format.html { redirect_to @product, notice: 'Product was successfully updated.' }
       format.json { head :no_content }
      else
        format.html { render action: :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @product.destroy
    
    respond_to do |format|
      format.html { redirect_to product_url }
      format.json { head :no_content }
    end
  end
  
  private
  
    def product_params
      params.require(:product).permit(:featured, :cost, :title, :description)
    end
  
    def set_product
      @product = Product.find(params[:id])
    end

    def authorize_product
      authorize(@product)
    end
end
