class BeaconsController < ApplicationController
  before_action :authenticate_user!, excepts: [:index, :show]
  before_action :set_beacon, except: [:index, :create]
  before_action :authorize_beacon, except: [:index, :create]
  before_action :set_form_resources, only: [:new, :edit]

  # GET /beacons
  # GET /beacons.json
  def index
    @beacons = policy_scope(Beacon)
  end

  # GET /beacons/1
  # GET /beacons/1.json
  def show
  end

  # GET /beacons/new
  def new
  end

  # GET /beacons/1/edit
  def edit
  end

  # POST /beacons
  # POST /beacons.json
  def create
    @beacon = Beacon.new(beacon_params)
    authorize_beacon

    respond_to do |format|
      if @beacon.save
        format.html { redirect_to @beacon, notice: 'Beacon was successfully created.' }
        format.json { render :show, status: :created, location: @beacon }
      else
        set_form_resources
        format.html { render :new }
        format.json { render json: { errors: @beacon.errors }, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /beacons/1
  # PATCH/PUT /beacons/1.json
  def update
    respond_to do |format|
      if @beacon.update_attributes(beacon_params)
        format.html { redirect_to @beacon, notice: 'Beacon was successfully updated.' }
        format.json { render :show, status: :ok, location: @beacon }
      else
        set_form_resources
        format.html { render :edit }
        format.json { render json: { errors: @beacon.errors }, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /beacons/1
  # DELETE /beacons/1.json
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