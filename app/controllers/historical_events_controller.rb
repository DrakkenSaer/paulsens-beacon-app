class HistoricalEventsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @historical_events = policy_scope(HistoricalEvent)
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
