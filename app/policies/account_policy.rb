class AccountPolicy < ApplicationPolicy
    class Scope < Scope
        def resolve
            if user.has_any_role?(:admin)
                scope.all
            else
                user
            end
        end
    end

    def show?
        user.has_any_role?(:standard, :admin)
    end
end