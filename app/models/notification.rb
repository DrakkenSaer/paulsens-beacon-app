class Notification < ApplicationRecord
  include Concerns::Polymorphic::Helpers
  include Concerns::Images::ValidatesAttachment

  belongs_to :notifiable, polymorphic: true, optional: true
  
  validates :title, :description, presence: true
  validates :title, :description, uniqueness: true
  
  resourcify
end
