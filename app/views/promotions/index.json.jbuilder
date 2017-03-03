json.promotions @promotions do |promotion|
  json.partial! 'promotions/promotion', promotion: promotion
end