class UserRolesController < ApplicationController
  before_action :authenticate_user!
  before_action :user_role_accessor, only: [:show]

  def index
    @roles = policy_scope(User.find(params[:account_id]).roles)
  end

  def show
    authorize @role
  end

  def new
  end

  def create
  end

  def destroy
  end
  
  private
    
    def user_role_accessor
      @role = User.find(params[:account_id]).roles.find(params[:id])
    end
  
    def user_role_params
      params.require(:role).permit(:name)
    end
end
