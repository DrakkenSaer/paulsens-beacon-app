class RolesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
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
    @role = Role.new(role_params)
    
    authorize(@role)

    respond_to do |format|
      if @role.save
        format.html { redirect_to @role, success: 'Role was successfully created.' }
        format.json { render json: @role, status: :created, location: @role }
      else
        format.html { render action: :new }
        format.json { render json: @role.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @role.update_attributes(role_params)
       format.html { redirect_to @role, notice: 'Role was successfully updated.' }
       format.json { head :no_content }
      else
        format.html { render action: :edit }
        format.json { render json: @role.errors, status: :unprocessable_entity }
      end
    end
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
      @role = Role.find(params[:id])
    end

    def authorize_role
      authorize(@role)
    end
end
