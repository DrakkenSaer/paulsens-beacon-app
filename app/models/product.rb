class Product < Item
    before_validation :set_default_cost, 
                      :set_default_featured

    has_many :promotions, as: :promotional
    accepts_nested_attributes_for :promotions, reject_if: :all_blank, allow_destroy: true

    validates :featured, inclusion: { in: [ true, false ] }

    # This is temporary, waiting to think of a better solution. Do not test.
    def promotions_attributes=(promotions_attributes)
        promotions_attributes.each do |key, promotion_attributes|
            promotion = promotions_attributes[key]

            if !promotion[:id].empty? && promotion[:_destroy] != "1"
                promotions << Promotion.find(promotion[:id])
            elsif !promotion[:id].empty? && promotion[:_destroy] == "1"
                Promotion.find(promotion[:id]).remove_resource_association
                break
            else
                super
            end
        end
    end

    protected
    
        def set_default_cost
            self.cost ||= '0.0' if self.has_attribute? :cost
        end
        
        def set_default_featured
            self.featured = false if (self.has_attribute? :featured) && self.featured.nil?
        end
end
