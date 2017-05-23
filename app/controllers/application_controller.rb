class ApplicationController < ActionController::Base
  include Pundit
  after_action :verify_authorized, except: :index, unless: :devise_controller?
  after_action :verify_policy_scoped, only: :index, unless: :devise_controller?
  before_action :configure_permitted_parameters

  protect_from_forgery with: :exception unless Rails.env.development?
  
  protected
  
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:phone, :address, :email])
      devise_parameter_sanitizer.permit(:account_update, keys: [:phone, :address, :email, points_attributes: [:value]])
    end

end