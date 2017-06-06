class User < ApplicationRecord
  include Concerns::Roles::RoleModification
  Roles::Helper.invoke(self)

  ROLES = [:customer, :employee, :admin]

  has_many :orders
  has_many :rewards, dependent: :destroy
  has_many :products, -> { distinct }, through: :rewards, source: :rewardable, source_type: 'Product'
  has_many :promotions, -> { distinct }, through: :rewards, source: :rewardable, source_type: 'Promotion'
  has_one  :credit, as: :cashable, dependent: :destroy

  accepts_nested_attributes_for :credit, reject_if: [:all_blank, :new_record?]

  rolify
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  serialize :preferences, Hash

  after_create :assign_default_role
  after_create :assign_default_credit

  def admin?
    self.has_role?(:admin)
  end

  protected
  
    def assign_default_role
      self.add_role(:standard) if self.roles.blank?
    end

    def assign_default_credit
      self.create_credit! if self.credit.nil?
    end

end