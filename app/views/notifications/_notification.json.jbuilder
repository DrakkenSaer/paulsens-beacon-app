json.(notification, :id, :title, :description, :entry_message, :exit_message, :created_at, :updated_at)
json.image notification.image.url(:medium)
