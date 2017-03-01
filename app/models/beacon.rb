class Beacon < ApplicationRecord
    before_validation :set_default_uuid
    before_validation :set_default_extra_uuids

    has_many :notifications
    
    accepts_nested_attributes_for :notifications, reject_if: :all_blank

    validates :title, :description, :uuid, :major_uuid, :minor_uuid, presence: true
    validates :title, :uuid, :major_uuid, :minor_uuid, uniqueness: true
    
    resourcify

    protected
    
        def set_default_uuid
            self.uuid ||= SecureRandom.uuid if self.has_attribute? :uuid
        end
        
        def set_default_extra_uuids
            self.major_uuid ||= SecureRandom.uuid if self.has_attribute? :major_uuid
            self.minor_uuid ||= SecureRandom.uuid if self.has_attribute? :minor_uuid
        end
end
