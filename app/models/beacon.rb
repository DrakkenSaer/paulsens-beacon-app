class Beacon < ApplicationRecord
    before_validation :set_default_uuid
    before_validation :set_default_extra_uuids

    has_many :notifications, as: :notifiable
    
    accepts_nested_attributes_for :notifications, reject_if: :all_blank, allow_destroy: true

    validates :title, :description, :uuid, :major_uuid, :minor_uuid, presence: true
    validates :title, :major_uuid, :minor_uuid, uniqueness: true
    
    resourcify
    
    # This is temporary, waiting to think of a better solution. Do not test.
    def notifications_attributes=(notifications_attributes)
        notifications_attributes.each do |key, notification_attributes|
            notification = notifications_attributes[key]

            if !notification[:id].nil? && notification[:_destroy] == "0"
                notifications << Notification.find(notification[:id])
            elsif !notification[:id].nil? && notification[:_destroy] == "1"
                Notification.find(notification[:id]).remove_resource_association
                break
            else
                super
            end
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
