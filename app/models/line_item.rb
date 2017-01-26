class LineItem < ApplicationRecord
  before_validation :set_default_item_cost
  
  belongs_to :order
  belongs_to :orderable, polymorphic: true

  validates :item_cost, presence: true

  def find_resource
    resource = self.orderable_type
    id = self.orderable_id
    @resource ||= resource.singularize.classify.constantize.find(id)
  end

  protected

    def set_default_item_cost
      self.item_cost = Product.find(self.orderable_id).cost if self.item_cost.nil?
    end

end
