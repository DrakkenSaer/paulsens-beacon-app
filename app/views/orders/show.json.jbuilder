json.(@order, :id, :created_at, :updated_at)
json.order @order.products, :id