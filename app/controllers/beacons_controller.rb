class BeaconsController < ResourceController
  before_action :authenticate_user!, excepts: [:index, :show]
  before_action :set_form_resources, only: [:new, :edit, :create]

  private

    def beacon_params
      params.require(:beacon).permit(:title,
                                      :description,
                                      :uuid,
                                      :minor_uuid,
                                      :major_uuid,
                                      notifications_attributes: [:id, :_destroy])
    end

    def set_form_resources
      @notifications = policy_scope(Notification)
    end

end