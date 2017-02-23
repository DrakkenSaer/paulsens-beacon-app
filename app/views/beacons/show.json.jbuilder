json.(@beacon, :id, :uuid, :title, :description, :created_at, :updated_at)
json.notifications @beacon.notifications, :id, :title, :description, :created_at, :updated_at