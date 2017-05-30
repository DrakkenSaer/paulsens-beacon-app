class CreditsController < Flexible::ResourceController
  include Concerns::Resource::Nested::SetParentResource

  before_action :authenticate_user!
  before_action :set_credit, except: [:index, :create]
  before_action :set_form_resources, except: [:index, :show, :destroy]

  private

    def set_credit
      @credit = params[:id] ? Credit.find(params[:id]) : current_user.credit
    end

    def set_form_resources
      @users = User.all
    end

    def credit_params
      params.require(:credit).permit(:user_id, :value)
    end

end