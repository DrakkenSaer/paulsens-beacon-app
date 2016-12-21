class Beacon < ApplicationRecord
    before_validation :set_default_uuid

    has_many :notifications
    
    validates :title, :description, :uuid, presence: true
    validates :title, :uuid, uniqueness: true
    
    resourcify

    protected
    
        def set_default_uuid
            self.uuid ||= SecureRandom.uuid if self.has_attribute? :uuid
        end
end
