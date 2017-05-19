json.extract! order, :id, :created_at, :updated_at

json.line_items order.line_items do |line_item|
    json.extract! line_item, :id, :orderable_type, :orderable_id, :cost, :created_at, :updated_at
    
    json.item line_item.polymorphic_resource, *line_item.polymorphic_resource.attribute_names
end