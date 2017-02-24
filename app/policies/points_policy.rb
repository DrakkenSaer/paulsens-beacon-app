class PointsPolicy < ApplicationPolicy
    class Scope < Scope
        def resolve
            if is_admin?
                scope.all
            end
        end
    end
    
    def show?
        true
    end

    def edit?
        is_admin?
    end

    def update?
        is_admin?
    end
end