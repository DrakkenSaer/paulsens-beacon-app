class Promotion < ApplicationRecord
  before_save :default_expiration
  
  belongs_to :promotional, polymorphic: true, optional: true
  
  validates :title, :description, :code, presence: true
  
  
  protected
  
  def expired?
     Promotion.expiration < DateTime.now
  end
  
  private
  
  def default_expiration
      self.update(expiration: Time.now + 2.weeks)
  end
end
