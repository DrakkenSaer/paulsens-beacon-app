class Notification < ApplicationRecord
  include Concerns::Images::ValidatesAttachment

  belongs_to :beacon, optional: true
  
  validates :title, :description, presence: true
  validates :title, :description, uniqueness: true
  
  resourcify
end
