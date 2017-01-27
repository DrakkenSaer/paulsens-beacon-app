class BeaconsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_beacon, except: [:index, :create]
  before_action :authorize_beacon, except: [:index, :create]
  

  def index
    @beacons = policy_scope(Beacon)
  end

  def show
  end

  def new
  end

  def create
    @beacon = Beacon.new(beacon_params)
    authorize(@beacon)
    if @beacon.save
      redirect_to @beacon, success: "Beacon successfully created!"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @beacon.update_attributes(beacon_params)
      redirect_to @beacon, success: "Beacon successfully updated!"
    # else
    #   render :edit
    end
  end

  def destroy
  end
  
private 
  def beacon_params
    params.require(:beacon).permit(:title, :description)
  end
  
  def set_beacon
    @beacon = Beacon.find(params[:id])
  end
  
  def authorize_beacon
     authorize(@beacon)
  end
end
