class AccountsController < Devise::RegistrationsController
  before_action :authenticate_user!

  def index
    @users = policy_scope(User)
  end

  def show
  end
end
