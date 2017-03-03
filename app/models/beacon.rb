class Beacon < ApplicationRecord
    before_validation :set_default_uuid
    before_validation :set_default_extra_uuids

    has_many :notifications
    
    accepts_nested_attributes_for :notifications, reject_if: :all_blank

    validates :title, :description, :uuid, :major_uuid, :minor_uuid, presence: true
    validates :title, :major_uuid, :minor_uuid, uniqueness: true
    
    resourcify
    
    # This is temporary, waiting to think of a better solution. Do not test.
    def notifications_attributes=(notifications_attributes)
        notifications_attributes.each do |notification_attributes|
            self.notifications << Notification.find(notification_attributes[:id])
        end
    end

    protected
    
        def set_default_uuid
            self.uuid ||= SecureRandom.uuid if self.has_attribute? :uuid
        end
        
        def set_default_extra_uuids
            self.major_uuid ||= SecureRandom.uuid if self.has_attribute? :major_uuid
            self.minor_uuid ||= SecureRandom.uuid if self.has_attribute? :minor_uuid
        end
end
