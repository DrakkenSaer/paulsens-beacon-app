class UserRolesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  before_action :set_role, except: [:index, :create]
  before_action :authorize_role, :authorize_user, except: [:index, :create]
  before_action :build_roles, only: [:new]

  def index
    @roles = policy_scope(@user.roles)
  end

  def show
  end

  def new
  end

  def create
    @role = params[:role_id].blank? ? Role.new(user_role_params) : Role.find(params[:role_id])
    authorize_role
    authorize_user

    if @role.users.include? @user 
      respond_to do |format|
        format.html { redirect_to user_roles_url(@user.id), notice: 'user already has this role!' }
        format.json { render :index, status: :ok, location: user_roles_url(@user.id) }
      end
    else 
      @role.save unless @role.id
      @role.users << @user  
    
      respond_to do |format|
        if @role.save
          format.html { redirect_to user_roles_url(@user.id), notice: 'role successfully added to user.' }
          format.json { render :index, status: :created, location: user_roles_url(@user.id) }
        else
          format.html { render :new }
          format.json { render json: @role.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def destroy
   #role removal stuff goes here
    respond_to do |format|
      format.html { redirect_to user_roles_url, notice: 'role was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  private

    def user_role_params
      params.require(:role).permit(:name)
    end
    
    def set_user
      @user = User.find(params[:user_id])
    end

    def set_role
      @role = params[:id] ? @user.roles.find(params[:id]) : Role.new
    end
    
    def authorize_user
      authorize @user
    end
    
    def authorize_role
      authorize @role
    end
    
    def build_roles
      @roles = policy_scope(Role)
    end

end
