json.(product, :id, :title, :cost, :featured, :description, :created_at, :updated_at)
json.image product.image.url(:medium)

json.promotions product.promotions do |promotion|
  json.partial! 'promotions/promotion', promotion: promotion
end