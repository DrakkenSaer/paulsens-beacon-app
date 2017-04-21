class HistoricalEventsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_historical_event, except: [:index, :create]
  before_action :authorize_historical_event, except: [:index, :create]

  # GET /historical_events
  # GET /historical_events.json
  def index
    @historical_events = policy_scope(HistoricalEvent)
  end

  # GET /historical_events/1
  # GET /historical_events/1.json
  def show
  end

  # GET /historical_events/new
  def new
  end

  # GET /historical_events/1/edit
  def edit
  end

  # POST /historical_events
  # POST /historical_events.json
  def create
    @historical_event = HistoricalEvent.new(historical_event_params)

    authorize_historical_event

    respond_to do |format|
      if @historical_event.save
        format.html { redirect_to @historical_event, success: 'Historical Event was successfully created.' }
        format.json { render :show, status: :created, location: @historical_event }
      else
        format.html { render :new }
        format.json { render json: @historical_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /historical_events/1
  # PATCH/PUT /historical_events/1.json
  def update
    respond_to do |format|
      if @historical_event.update_attributes(historical_event_params)
        format.html { redirect_to @historical_event, notice: 'Historical Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @historical_event }
      else
        format.html { render :edit }
        format.json { render json: @historical_event.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /historical_events/1
  # DELETE /historical_events/1.json
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
