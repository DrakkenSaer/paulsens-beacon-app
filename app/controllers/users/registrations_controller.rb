class Users::RegistrationsController < Devise::RegistrationsController
  include Concerns::Resource::Role::ResourceRoleChange
  respond_to :html, :json

  prepend_before_action :authenticate_scope!, except: [:new, :create, :cancel]
  prepend_before_action :configure_permitted_parameters
  before_action :set_user, except: [:index, :create]
  before_action :authorize_user, except: [:index, :create]

  def index
    @users = policy_scope(User)
  end

  def show
  end
  
  def update
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

    resource_updated = update_resource(resource, account_update_params)
    yield resource if block_given?
    respond_to do |format|
    if resource_updated
      if is_flashing_format?
        flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
          :update_needs_confirmation : :updated
        set_flash_message :notice, flash_key
      end

      # Respond_with returns no content for some reason
      format.html { redirect_to after_update_path_for(resource), flash: { success: 'User was successfully updated.' } }
      format.json { render :show, status: :ok, location: after_update_path_for(resource) }
    else
      clean_up_passwords resource
      set_minimum_password_length

      # Respond_with returns no content for some reason
      format.html { render action: :edit }
      format.json { render json: { errors: resource.errors }, status: :unprocessable_entity }
    end
    end
  end

  def destroy
    resource.destroy
    warden.logout(resource)
    warden.clear_strategies_cache!(scope: resource)
    set_flash_message! :notice, :destroyed
    yield resource if block_given?
    respond_with_navigational(resource){ redirect_to users_path }
  end
  
  def deactivate
    resource.deactivate!
    Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
    set_flash_message! :notice, :deactivated
    yield resource if block_given?
    respond_with_navigational(resource){ redirect_to after_sign_out_path_for(resource_name) }
  end


  private

    def set_user
      @user = params[:id] ? User.find(params[:id]) : current_user || User.new
    end

    def authorize_user
      authorize @user
    end


  protected

    def update_resource(resource, params)
      if resource != current_user && current_user.admin? && params[:current_password].nil?
        compacted_params = params.delete_if { |k, v| v.empty? }
        resource.update(compacted_params)
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
