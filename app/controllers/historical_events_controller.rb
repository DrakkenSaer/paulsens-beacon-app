class HistoricalEventsController < ApplicationController
  respond_to :html, :json

  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_historical_event, except: [:index, :create]
  before_action :authorize_historical_event, except: [:index, :create]

  def index
    @historical_events = policy_scope(HistoricalEvent)
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    @historical_event = HistoricalEvent.create(historical_event_params)
    authorize_historical_event
    respond_with @historical_event
  end

  def update
    @historical_event.update_attributes(historical_event_params)
    respond_with @historical_event
  end

  def destroy
    @historical_event.destroy

    respond_to do |format|
      format.html { redirect_to historical_events_url, notice: 'historical_event was successfully destroyed.'  }
      format.json { head :no_content }
    end
  end

  private

    def historical_event_params
      params.require(:historical_event).permit(:title, :description, :date, :image)
    end
  
    def set_historical_event
      @historical_event = params[:id] ? HistoricalEvent.find(params[:id]) : HistoricalEvent.new
    end
  
    def authorize_historical_event
      authorize(@historical_event)
    end

end
