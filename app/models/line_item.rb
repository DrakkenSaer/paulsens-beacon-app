class LineItem < ApplicationRecord
  before_validation :default_item_cost
  
  belongs_to :order
  belongs_to :orderable, polymorphic: true

  validates :item_cost, presence: true
  
  def default_item_cost
    self.item_cost = Product.find(self.orderable_id).cost if self.item_cost.nil?
  end
  
  def find_resource
    resource = self.orderable_type
    id = self.orderable_id
    @commentable = resource.singularize.classify.constantize.find(id)
  end
end
