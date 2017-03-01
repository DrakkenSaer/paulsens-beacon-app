class Notification < ApplicationRecord
  belongs_to :beacon, optional: true
  
  validates :title, :description, :entry_message, :exit_message, presence: true
  validates :title, :description, uniqueness: true
  
  resourcify
end
