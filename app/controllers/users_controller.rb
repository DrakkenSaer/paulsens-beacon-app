class UsersController < ApplicationController
  before_action :set_user, except: [:index]
  before_action :authorize_user, except: [:index]

  # GET /users
  # GET /users.json
  def index
    @users = policy_scope(User)
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = params[:id] ? User.find(params[:id]) : current_user
    end

    def authorize_user
      authorize @user
    end
end
