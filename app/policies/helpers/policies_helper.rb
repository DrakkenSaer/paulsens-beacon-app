module Helpers::PoliciesHelper
  def is_admin?(user = self.user)
    user.has_role?(:admin)
  end
  
  def resource_user?(user = self.user)
    record.users.include?(user)
  end
  
  def matching_user?(user = self.user)
    record.id == user.id
  end
end