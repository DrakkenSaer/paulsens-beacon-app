class Promotion < ApplicationRecord
  before_validation :set_default_cost, 
                    :set_default_daily_deal, 
                    :set_default_featured, 
                    :set_default_expiration,
                    :set_default_redeem_count
  
  belongs_to :promotional, polymorphic: true, optional: true
  has_many :line_items, as: :orderable
  has_many :orders, through: :line_items

  validates :title, 
            :description, 
            :code, 
            :expiration, 
            :cost, 
            :redeem_count, 
            :expiration, presence: true
  
  #validates :daily_deal, :featured, inclusion: { in: [ true, false ] }

  resourcify
  
  def expired?
     self.expiration < Time.now
  end

  def find_resource
    resource = self.orderable_type
    id = self.orderable_id
    @resource = resource.singularize.classify.constantize.find(id)
  end

  protected

    def set_default_cost
        self.cost ||= '0.0' if self.has_attribute? :cost
    end

    def set_default_redeem_count
        self.redeem_count ||= 0 if self.has_attribute? :redeem_count
    end
    
    def set_default_featured
        self.featured = false if (self.has_attribute? :featured) && self.featured.nil?
    end

    def set_default_daily_deal
        self.daily_deal = false if (self.has_attribute? :daily_deal) && self.daily_deal.nil?
    end

    def set_default_expiration
      self.expiration = Time.now + 2.weeks if self.expiration.nil?
    end

end
