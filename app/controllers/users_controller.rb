class UsersController < DeviseController
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

  def edit
    render template: 'devise/registrations/edit'
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = params[:id] ? User.find(params[:id]) : current_user
    end
  
    def authorize_user
      authorize @user
    end

  protected
  
    def devise_mapping
      request.env["devise.mapping"] = Devise.mappings[:user]
      @devise_mapping ||= request.env["devise.mapping"]
    end

end
