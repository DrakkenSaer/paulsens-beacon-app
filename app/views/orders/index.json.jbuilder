json.orders @orders do |order| 
    json.(order, :id, :created_at, :updated_at)
    json.products order.products
    json.promotions order.promotions
end