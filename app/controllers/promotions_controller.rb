class PromotionsController < ResourceController
  before_action :authenticate_user!, except: [:index, :show]

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

end
