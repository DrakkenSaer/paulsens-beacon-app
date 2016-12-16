class Order < ApplicationRecord
    belongs_to :user
    has_many :line_items, as: :orderable 
    has_many :products, through: :line_items, source: :orderable, source_type: 'Product'
    has_many :promotions, through: :line_items, source: :orderable, source_type: 'Promotion'
end
