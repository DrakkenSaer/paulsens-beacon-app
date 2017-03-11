class Beacon < ApplicationRecord
    has_many :notifications, as: :notifiable
    accepts_nested_attributes_for :notifications, reject_if: :all_blank, allow_destroy: true

    validates :title, :description, :uuid, :major_uuid, :minor_uuid, presence: true
    validates :title, :major_uuid, :minor_uuid, uniqueness: true
    validates :major_uuid, :minor_uuid, numericality: true

    resourcify
    
    # This is temporary, waiting to think of a better solution. Do not test.
    def notifications_attributes=(notifications_attributes)
        notifications_attributes.each do |key, notification_attributes|
            notification = notifications_attributes[key]

            if !notification[:id].empty? && notification[:_destroy] != "1"
                notifications << Notification.find(notification[:id])
            elsif !notification[:id].empty? && notification[:_destroy] == "1"
                Notification.find(notification[:id]).remove_resource_association
                break
            else
                super
            end
        end
    end
end
