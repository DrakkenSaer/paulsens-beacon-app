class RolePolicy < ApplicationPolicy
    class Scope < Scope
        def resolve
            if is_admin?
                scope.all
            end
        end
    end

    def show?
        is_admin?
    end

    def create?
        is_admin?
    end

    def update?
        is_admin?
    end

    def destroy?
        is_admin?
    end
end