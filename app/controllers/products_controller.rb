class ProductsController < ResourceController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_form_resources, except: [:index, :show, :destroy]


  private

    def product_params
      params.require(:product).permit(:featured,
                                      :cost,
                                      :title,
                                      :description,
                                      :image,
                                      promotions_attributes: [:id, :_destroy])
    end

    def set_form_resources
      @promotions = policy_scope(Promotion)
    end

end
