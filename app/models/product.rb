class Product < ApplicationRecord
    before_validation :set_default_cost, 
                      :set_default_featured
    
    has_many :promotions, as: :promotional
    has_many :line_items, as: :orderable
    has_many :orders, through: :line_items
    
    validates :title, :description, :cost, presence: true
    validates :featured, inclusion: { in: [ true, false ] }
    
    protected
    
        def set_default_cost
            self.cost ||= '0.0' if self.has_attribute? :cost
        end
        
        def set_default_featured
            self.featured = false if (self.has_attribute? :featured) && self.featured.nil?
        end
end
