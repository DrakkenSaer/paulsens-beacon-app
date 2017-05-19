json.extract! reward, :id, :created_at, :updated_at, :resource_state
json.reward reward.polymorphic_resource, *reward.polymorphic_resource.attribute_names
json.user reward.user.email

json.url reward_url(reward, format: :json)
