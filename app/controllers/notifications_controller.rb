class NotificationsController < Flexible::ResourceController

  before_action :authenticate_user!

  private

    def notification_params
      params.require(:notification).permit(:title,
                                            :description,
                                            :entry_message,
                                            :exit_message,
                                            :beacon_id,
                                            :image)
    end

end
