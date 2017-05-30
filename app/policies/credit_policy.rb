class CreditPolicy < ApplicationPolicy
    class Scope < Scope
        def resolve
            scope.all
        end
    end
    
    def show?
        true
    end

    def create?
        is_admin?
    end

    def update?
        is_admin? or resource_user?
    end
end