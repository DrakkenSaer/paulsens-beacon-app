class UsersController < ResourceController
  include Concerns::Resource::State::ResourceStateChange

  before_action :authenticate_user!

  private

    def user_params
      params.require(:user).permit(:email, :phone, :address, credit_attributes: [:id, :value])
    end

end
