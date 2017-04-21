json.extract! user, :id, :created_at, :updated_at
json.points user.points.value
json.url user_url(user, format: :json)