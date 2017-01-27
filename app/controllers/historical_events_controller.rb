class HistoricalEventsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_historical_event, except: [:index, :create]
  before_action :authorize_hisorical_event, except: [:index, :create]

  def index
    @historical_events = policy_scope(HistoricalEvent)
  end

  def show
  end

  def new
  end

  def create
    @historical_event = HistoricalEvent.new(historical_event_params)
    authorize(@historical_event)
    respond_to do |format|
      if @historical_event.save
        format.html { redirect_to @historical_event, notice: 'Historical Event was successfully created.' }
        format.json { render json: @historical_event, status: :created, location: @historical_event }
      else
        format.html { render action: "new" }
        format.json { render json: @historical_event.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
  end

  def destroy
    @historical_event.destroy
    
    respond_to do |format|
      format.html {redirect_to historical_event_url}
      format.json {head :no_content}
    end
  end
  
  private
  def historical_event_params
    params.require(:historical_event).permit(:title, :description, :date)
  end
  def authorize_hisorical_event
    authorize(@historical_event)
  end
  def set_historical_event
    @historical_event = HistoricalEvent.find(params[:id])
  end
end
