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

    def index?
        user.has_any_role?(:standard, :admin)
    end

    def show?
        user.has_any_role?(:standard, :admin)
    end
end