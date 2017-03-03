class NotificationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_notification, except: [:index, :create]
  before_action :authorize_notification, except: [:index, :create]
  
  # GET /notifications
  # GET /notifications.json
  def index
    @notifications = policy_scope(Notification)
  end

  # GET /notifications/1
  # GET /notifications/1.json
  def show
  end

  # GET /notifications/new
  def new
  end
  
  # GET /notifications/1/edit
  def edit
  end

  # POST /notifications
  # POST /notifications.json
  def create
    @notification = Notification.new(notification_params)
    authorize_notification

    respond_to do |format|
      if @notification.save
        format.html { redirect_to @notification, notice: 'Notification was successfully created.' }
        format.json { render :show, status: :created, location: @notification }
      else
        format.html { render :new }
        format.json { render json: @notification.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # PATCH/PUT /notifications/1
  # PATCH/PUT /notifications/1.json
  def update
    respond_to do |format|
      if @notification.update_attributes(notification_params)
        format.html { redirect_to @notification, notice: 'Notification was successfully updated.' }
        format.json { render :show, status: :ok, location: @notification }
      else
        format.html { render :edit }
        format.json { render json: @notification.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notifications/1
  # DELETE /notifications/1.json
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
