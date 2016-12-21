class OrderPolicy < ApplicationPolicy
    class Scope < Scope
        def resolve
            if user.has_any_role?(:admin)
                scope.all
            else
                scope.where(user: user)
            end
        end
    end

    def update?
        user.has_any_role?(:admin)
    end

    def destroy?
        user.has_any_role?(:admin)
    end
end