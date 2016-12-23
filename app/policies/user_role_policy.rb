class RolePolicy < ApplicationPolicy
    class Scope < Scope
        def resolve
            if user.has_any_role?(:admin)
                scope.all
            end
        end
    end

    def show?
        user.has_any_role?(:admin)
    end

    def create?
        user.has_any_role?(:admin)
    end

    def destroy?
        user.has_any_role?(:admin)
    end
end