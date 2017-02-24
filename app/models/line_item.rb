class LineItem < ApplicationRecord
  include Concerns::Polymorphic::Helpers

  before_validation :set_default_item_cost
  
  belongs_to :order
  belongs_to :orderable, polymorphic: true

  validates :item_cost, presence: true

  protected

    def set_default_item_cost
      self.item_cost = Product.find(self.orderable_id).cost if self.item_cost.nil?
    end

end
