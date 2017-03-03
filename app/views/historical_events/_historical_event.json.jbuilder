json.(historical_event, :id, :title, :description, :date, :created_at, :updated_at)
json.image historical_event.image.url(:medium)
