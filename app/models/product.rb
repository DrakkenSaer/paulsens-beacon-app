class Product < ApplicationRecord
    has_many :promotions, as: :promotional
    has_many :line_items, as: :orderable 
    has_many :orders, through: :line_items
end
