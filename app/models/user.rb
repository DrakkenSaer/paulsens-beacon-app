class User < ApplicationRecord
  has_many :orders
  
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
