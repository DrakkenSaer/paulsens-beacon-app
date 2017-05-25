class BeaconsController < ApplicationController
  respond_to :html, :json

  before_action :authenticate_user!, excepts: [:index, :show]
  before_action :set_beacon, except: [:index, :create]
  before_action :authorize_beacon, except: [:index, :create]
  before_action :set_form_resources, only: [:new, :edit, :create]

  def index
    @beacons = policy_scope(Beacon)
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    @beacon = Beacon.create(beacon_params)
    authorize_beacon
    respond_with @beacon
  end

  def update
    @beacon.update_attributes(beacon_params)
    respond_with @beacon
  end

  def destroy
    @beacon.destroy
    respond_to do |format|
      format.html { redirect_to beacons_url, notice: 'Beacon was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def beacon_params
      params.require(:beacon).permit(:title,
                                      :description,
                                      :uuid,
                                      :minor_uuid,
                                      :major_uuid,
                                      notifications_attributes: [:id, :_destroy])
    end

    def set_beacon
      @beacon = params[:id] ? Beacon.find(params[:id]): Beacon.new
    end

    def authorize_beacon
       authorize(@beacon)
    end

    def set_form_resources
      @notifications = policy_scope(Notification)
    end

end