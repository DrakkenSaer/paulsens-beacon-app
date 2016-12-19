class Beacon < ApplicationRecord
    has_many :notifications
    
    validates :uuid, :title, :description, presence: true
    validates :uuid, length: { is: 36 }, uniqueness: true
    validates :title, uniqueness: true
end
