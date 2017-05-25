class PointsController < ApplicationController
  respond_to :html, :json

  include Concerns::Resource::Nested::SetResource

  before_action :authenticate_user!
  before_action :set_resource
  before_action :set_points, except: [:index, :create]
  before_action :authorize_points, except: [:index, :create]
  before_action :set_form_resources, except: [:index, :show, :destroy]

  def index
    @points = policy_scope(@resource.points)
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    @point = Point.create(points_params)
    respond_with @point
  end

  def update
    @point.update(points_params)
    respond_with @point
  end

  def destroy
    @point.destroy
    respond_to do |format|
      format.html { redirect_to points_index_url, notice: 'Points was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_points
      @point = params[:id] ? Point.find(params[:id]) : current_user.points
    end
  
    def authorize_points
      authorize @point
    end
  
    def set_form_resources
      @users = User.all
    end

    def points_params
      params.require(:point).permit(:user_id, :value)
    end

end
