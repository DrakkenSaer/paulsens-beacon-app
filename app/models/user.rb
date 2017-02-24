class User < ApplicationRecord
  has_many :orders
  has_many :line_items, through: :orders, as: :orderable
  has_many :products, -> { distinct }, through: :line_items, source: :orderable, source_type: 'Product'
  has_many :promotions, -> { distinct }, through: :line_items, source: :orderable, source_type: 'Promotion'
  has_one :points, as: :pointable

  rolify
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  serialize :preferences, Hash

  after_create :assign_default_role
  after_create :assign_default_points

  protected
  
    def assign_default_role
      self.add_role(:standard) if self.roles.blank?
    end

    def assign_default_points
      self.create_points! if self.points.nil?
    end
end