class Promotion < ApplicationRecord
  include Concerns::Polymorphic::Helpers
  include Concerns::Purchasable
  include Concerns::Images::ValidatesAttachment

  before_validation :set_default_cost, 
                    :set_default_daily_deal, 
                    :set_default_featured, 
                    :set_default_expiration,
                    :set_default_redeem_count
  
  belongs_to :promotional, polymorphic: true, optional: true

  validates :title, 
            :description, 
            :code, 
            :expiration, 
            :cost, 
            :redeem_count, presence: true

  validates :title, :code, uniqueness: true
  validates :daily_deal, :featured, inclusion: { in: [ true, false ] }

  resourcify
  
  def expired?
     self.expiration < Time.now
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
