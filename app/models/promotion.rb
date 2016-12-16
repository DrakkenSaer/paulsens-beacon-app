class Promotion < ApplicationRecord
  after_create :set_default_expiration
  
  belongs_to :promotional, polymorphic: true, optional: true
  has_many :line_items, as: :orderable 
  has_many :orders, through: :line_items

  
  validates :title, :description, :code, presence: true
  
  def expired?
     self.expiration < Time.now
  end

  protected

    def set_default_expiration
      if self.expiration.nil?
        self.update(expiration: self.created_at + 2.weeks)
      end
    end
end
