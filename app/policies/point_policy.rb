class PointPolicy < ApplicationPolicy
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
        is_admin?
    end
end