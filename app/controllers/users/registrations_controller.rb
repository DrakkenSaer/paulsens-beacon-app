class Users::RegistrationsController < Devise::RegistrationsController
  prepend_before_action :authenticate_scope!, except: [:new, :create, :cancel]
  prepend_before_action :configure_permitted_parameters
  before_action :set_user, except: [:index, :create]
  before_action :authorize_user, except: [:index, :create]

  # GET /users
  # GET /users.json
  def index
    @users = policy_scope(User)
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end
  
  def update
    self.resource = @user
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

    require 'pry'; binding.pry
    resource_updated = update_resource(resource, account_update_params)
    yield resource if block_given?
    respond_to do |format|
      if resource_updated
        if is_flashing_format?
          flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
            :update_needs_confirmation : :updated
          set_flash_message :notice, flash_key
        end
  
        format.html { redirect_to after_update_path_for(resource), flash: { success: 'User was successfully updated.' } }
        format.json { render :show, status: :ok, location: after_update_path_for(resource) }
      else
        clean_up_passwords resource
        set_minimum_password_length

        format.html { render action: :edit }
        format.json { render json: resource.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_user
      if current_user.present?
        @user = params[:id] ? User.find(params[:id]) : current_user
      else
        @user = params[:id] ? User.find(params[:id]) : User.new
      end
    end
  
    def authorize_user
      authorize @user
    end

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:phone, :address, :email])
      devise_parameter_sanitizer.permit(:account_update, keys: [:phone, :address, :email, points_attributes: [:value]])
    end

    def update_resource(resource, params)
      if resource != current_user && current_user.admin? && params[:current_password].nil?
        resource.update(params)
      else
        super
      end
    end
  
    def after_update_path_for(resource)
      current_user.admin? ? user_path(resource) : super
    end

    def devise_mapping
      request.env["devise.mapping"] = Devise.mappings[:user]
      @devise_mapping ||= request.env["devise.mapping"]
    end

end
