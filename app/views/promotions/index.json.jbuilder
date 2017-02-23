json.promotions @promotions do |promotion| 
  json.id promotion.id
  json.title promotion.title
  json.description promotion.description
  json.cost promotion.cost
  json.featured promotion.featured
  json.(promotion, :created_at, :updated_at)
end