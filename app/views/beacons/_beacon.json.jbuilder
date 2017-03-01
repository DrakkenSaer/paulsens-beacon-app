json.(beacon, :id, :uuid, :minor_uuid, :major_uuid, :title, :description, :created_at, :updated_at)
json.notifications beacon.notifications, :id, :title, :description, :created_at, :updated_at