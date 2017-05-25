class RolesController < ApplicationController
  respond_to :html, :json

  before_action :authenticate_user!
  before_action :set_role, except: [:index, :create]
  before_action :authorize_role, except: [:index, :create]

  def index
    @roles = policy_scope(Role)
  end

  def show
  end

  def new
  end

  def create
    @role = Role.create(role_params)
    authorize_role
    respond_with @role
  end

  def edit
  end

  def update
    @role.update_attributes(role_params)
    respond_with @role
  end

  def destroy
    @role.destroy
    respond_to do |format|
      format.html { redirect_to roles_url }
      format.json { head :no_content }
    end
  end

  private

    def role_params
      params.require(:role).permit(:name, :resource_type, :resource_id)
    end
  
    def set_role
      @role = params[:id] ? Role.find(params[:id]) : Role.new
    end
  
    def authorize_role
      authorize(@role)
    end

end
