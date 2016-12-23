class RegistrationPolicy < ApplicationPolicy
    def create?
        user.has_any_role?(:admin)
    end
end