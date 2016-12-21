class RegistrationPolicy < ApplicationPolicy
    class Scope < Scope
        def resolve
            if user.has_any_role?(:admin)
                scope.all
            end
        end
    end

    def create?
        user.has_any_role?(:admin)
    end
end