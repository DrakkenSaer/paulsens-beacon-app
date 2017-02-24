class PointsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_points, except: [:index]
  before_action :authorize_points, except: [:index]
  
  def show
  end

  def edit
  end

  def update
    respond_to do |format|
      if @points.update_attributes(points_params)
        format.html { redirect_to @points, notice: 'Points was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: :edit }
        format.json { render json: @points.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  
    def points_params
      params.require(:points).permit(:value)
    end
  
    def set_points
      @points = params[:id] ? Points.find(params[:id]) : Points.new
    end

    def authorize_points
      authorize(@points)
    end

end
