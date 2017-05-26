class PointsController < Flexible::ResourceController
  include Concerns::Resource::Nested::SetParentResource

  before_action :authenticate_user!
  before_action :set_points, except: [:index, :create]
  before_action :set_form_resources, except: [:index, :show, :destroy]

  private

    def set_points
      @point = params[:id] ? Point.find(params[:id]) : current_user.points
    end

    def set_form_resources
      @users = User.all
    end

    def points_params
      params.require(:point).permit(:user_id, :value)
    end

end