json.order do
    json.extract! order, :id, :created_at, :updated_at

    json.line_items , 


    json.array! order.line_items do |line_item|
        json.extract! line_item, :id, :orderable_type, :orderable_id, :item_cost, :created_at, :updated_at

        json.author do
            json.first_name comment.author.first_name
            json.last_name comment.author.last_name
        end
    end
end


json.products order.products, :id, :title, :cost, :featured, :description, :created_at, :updated_at
json.promotions order.promotions, :id, :promotional_type, :promotional_id, :title, :description, :code, :redeem_count, :daily_deal, :featured, :cost, :expiration, :created_at, :updated_at