class HistoricalEventsController < ResourceController
  before_action :authenticate_user!, except: [:index, :show]

  private

    def historical_event_params
      params.require(:historical_event).permit(:title, :description, :date, :image)
    end

end
