json.extract! order, :id, :created_at, :updated_at

json.line_items order.line_items do |line_item|
    json.extract! line_item, :id, :lineable_type, :lineable_id, :item_cost, :created_at, :updated_at
    
    json.item line_item.find_resource, *line_item.find_resource.attribute_names
end