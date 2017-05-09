class Users::RegistrationsController < Devise::RegistrationsController
  prepend_before_action :authenticate_scope!, except: [:new, :create, :cancel]

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

    resource_updated = update_resource(resource, account_update_params)
    yield resource if block_given?
    if resource_updated
      if is_flashing_format?
        flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
          :update_needs_confirmation : :updated
        set_flash_message :notice, flash_key
      end
      respond_with resource, location: after_update_path_for(resource)
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
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
  
    def update_resource(resource, params)
      current_user.admin? ? resource.update_without_password(params) : super
    end
  
    def after_update_path_for(resource)
      current_user.admin? ? user_path(resource) : super
    end

    def devise_mapping
      request.env["devise.mapping"] = Devise.mappings[:user]
      @devise_mapping ||= request.env["devise.mapping"]
    end

end
