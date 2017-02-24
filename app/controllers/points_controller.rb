class PointsController < ApplicationController
  def show
    @points = 
    @resource = @points.find_resource
  end

  def edit
  end

  def update
  end
end
