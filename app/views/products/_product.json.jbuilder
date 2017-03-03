json.(product, :id, :title, :cost, :featured, :description, :created_at, :updated_at)
json.promotions roduct.promotions do |promotion|
  json.partial! 'promotions/promotion', promotion: promotion
end