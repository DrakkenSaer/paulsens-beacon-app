class UserPolicy < ApplicationPolicy
    class Scope < Scope
        def resolve
            if is_admin?
                scope.all
            else
                user
            end
        end
    end

    def show?
        is_admin? or matching_user?
    end

    def update?
        is_admin? or matching_user?
    end

    def create?
        is_admin?
    end
end