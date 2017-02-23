json.id @historical_event.id
json.title @historical_event.title
json.description @historical_event.description
json.date @historical_event.date
json.(@historical_event, :created_at, :updated_at)
