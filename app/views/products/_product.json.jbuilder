json.(product, :id, :title, :cost, :featured, :description, :created_at, :updated_at)
json.promotions product.promotions, :id, :promotional_type, :promotional_id, :title, :description, :code, :redeem_count, :daily_deal, :featured, :cost, :expiration, :created_at, :updated_at
