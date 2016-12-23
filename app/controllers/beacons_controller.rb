class BeaconsController < ApplicationController
  before_action :authenticate_user!

  def index
    @beacons = policy_scope(Beacon)
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
