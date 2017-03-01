class LineItem < ApplicationRecord
  include Concerns::Polymorphic::Helpers

  before_validation :set_default_item_cost
  
  belongs_to :lineable, polymorphic: true
  belongs_to :order, inverse_of: :line_items

  validates :item_cost, presence: true

  protected

    def set_default_item_cost
      self.item_cost = self.send(resourcable_type_name).constantize.find( self.send(resourcable_id_name) ).cost if self.item_cost.nil?
    end

end
