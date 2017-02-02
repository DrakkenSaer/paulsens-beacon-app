class OrderPolicy < ApplicationPolicy
    class Scope < Scope
        def resolve
            if is_admin?
                scope.all
            else
                scope.where(user: user)
            end
        end
    end

    def update?
        is_admin?
    end

    def destroy?
        is_admin?
    end
end