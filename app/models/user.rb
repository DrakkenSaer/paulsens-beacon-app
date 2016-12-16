class User < ApplicationRecord
  has_many :orders
  has_many :line_items, as: :orderable
  has_many :products, through: :line_items, source: :orderable, source_type: 'Product'
  has_many :promotions, through: :line_items, source: :orderable, source_type: 'Promotion'
  
  rolify
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  store_accessor :preferences
  
  after_create :assign_default_role

  def assign_default_role
    self.add_role(:standard) if self.roles.blank?
  end
end
