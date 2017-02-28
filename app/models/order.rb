class Order < ApplicationRecord
    belongs_to :user
    has_many :line_items, dependent: :destroy
    has_many :products, through: :line_items, source: :lineable, source_type: 'Product'
    has_many :promotions, through: :line_items, source: :lineable, source_type: 'Promotion'

    resourcify
end
