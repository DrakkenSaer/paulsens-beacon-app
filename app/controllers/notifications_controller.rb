class NotificationsController < ApplicationController
  respond_to :html, :json

  before_action :authenticate_user!
  before_action :set_notification, except: [:index, :create]
  before_action :authorize_notification, except: [:index, :create]

  def index
    @notifications = policy_scope(Notification)
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    @notification = Notification.create(notification_params)
    authorize_notification
    respond_with @notification
  end

  def update
    @notification.update_attributes(notification_params)
    respond_with @notification
  end

  def destroy
    @notification.destroy
    respond_to do |format|
      format.html { redirect_to notifications_url, notice: 'Notification was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def notification_params
      params.require(:notification).permit(:title,
                                            :description,
                                            :entry_message,
                                            :exit_message,
                                            :beacon_id,
                                            :image)
    end

    def set_notification
      @notification = params[:id] ? Notification.find(params[:id]): Notification.new
    end

    def authorize_notification
       authorize(@notification)
    end

end
