class LineItem < ApplicationRecord
  belongs_to :order
  belongs_to :orderable, polymorphic: true
  
  validates :item_cost, presence: true
end
