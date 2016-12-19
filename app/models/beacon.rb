class Beacon < ApplicationRecord
    has_many :notifications
    
    validates :title, :description, presence: true
    validates :title, uniqueness: true
end
