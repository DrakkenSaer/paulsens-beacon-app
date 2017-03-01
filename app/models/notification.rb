class Notification < ApplicationRecord
  belongs_to :beacon, optional: true
  
  validates :title, :description, presence: true
  validates :title, :description, uniqueness: true
  
  resourcify
end
