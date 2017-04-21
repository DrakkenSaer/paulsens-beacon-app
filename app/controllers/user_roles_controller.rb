class UserRolesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user_role, except: [:index, :create]
  before_action :authorize_role, except: [:index, :create]

  def index
    @roles = policy_scope(User.find(params[:user_id]).roles)
  end

  def show
  end

  def new
  end

  def create
  end

  def destroy
  end

  private

  def user_role_params
    params.require(:role).permit(:name)
  end

  def set_user_role
    @role = User.find(params[:account_id]).roles { params[:id] ? find(params[:id]) : new }
  end

  def authorize_user_role
    authorize @role
  end
end
