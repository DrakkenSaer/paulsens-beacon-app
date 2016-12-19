class Notification < ApplicationRecord
  belongs_to :beacon
  
  validates :title, :description, presence: true, uniqueness: true
end
