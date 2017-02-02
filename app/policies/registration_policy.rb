class RegistrationPolicy < ApplicationPolicy
    def create?
        is_admin?
    end
end