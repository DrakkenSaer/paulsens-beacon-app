json.(order, :id, :created_at, :updated_at)
json.products order.products, :id, :title, :cost, :featured, :description, :created_at, :updated_at
json.line_items order.line_items, :id, :orderable_type, :orderable_id, :item_cost, :created_at, :updated_at
json.promotions order.promotions, :id, :promotional_type, :promotional_id, :title, :description, :code, :redeem_count, :daily_deal, :featured, :cost, :expiration, :created_at, :updated_at