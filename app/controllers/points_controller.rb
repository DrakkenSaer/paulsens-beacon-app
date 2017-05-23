class PointsController < ApplicationController
  include Concerns::Resource::Nested::SetResource

  before_action :authenticate_user!
  before_action :set_resource
  before_action :set_form_resources, only: [:new, :edit]
  before_action :set_points, except: [:index, :create]
  before_action :authorize_points, except: [:index, :create]

  def index
    @points = policy_scope(@resource.points)
  end

  def show
  end

  # GET /points/new
  def new
  end

  # GET /points/1/edit
  def edit
  end

  # POST /points
  # POST /points.json
  def create
    @point = Point.new(points_params)

    respond_to do |format|
      if @point.save
        format.html { redirect_to @point, notice: 'Points was successfully created.' }
        format.json { render :show, status: :created, location: @point }
      else
        format.html { render :new }
        format.json { render json: @point.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /points/1
  # PATCH/PUT /points/1.json
  def update
    respond_to do |format|
      if @point.update(points_params)
        format.html { redirect_to @point, notice: 'Points was successfully updated.' }
        format.json { render :show, status: :ok, location: @point }
      else
        format.html { render :edit }
        format.json { render json: @point.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /points/1
  # DELETE /points/1.json
  def destroy
    @point.destroy
    respond_to do |format|
      format.html { redirect_to points_index_url, notice: 'Points was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  
    # Use callbacks to share common setup or constraints between actions.
    def set_points
      @point = params[:id] ? Point.find(params[:id]) : current_user.points
    end
  
    def authorize_points
      authorize @point
    end
  
    def set_form_resources
      @users = User.all
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def points_params
      params.require(:point).permit(:user_id, :value)
    end

end
