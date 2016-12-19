class Notification < ApplicationRecord
  belongs_to :beacon, optional: true
  
  validates :title, :description, presence: true, uniqueness: true
end
