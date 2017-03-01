class Order < ApplicationRecord
    belongs_to :user
    has_many :line_items, dependent: :destroy, inverse_of: :order
    has_many :products, through: :line_items, source: :lineable, source_type: 'Product'
    has_many :promotions, through: :line_items, source: :lineable, source_type: 'Promotion'
    
    accepts_nested_attributes_for :products, :promotions, reject_if: :all_blank

    resourcify


    # This is temporary, waiting to think of a better solution. Do not test.
    def promotions_attributes=(promotions_attributes)
        promotions_attributes.each do |key, promotion_attributes|
            line_items.build(lineable_type: 'Promotion', lineable_id: promotions_attributes[key][:id], item_cost: promotions_attributes[key][:cost])
        end
    end

end
