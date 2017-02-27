class PointPolicy < ApplicationPolicy
    class Scope < Scope
        def resolve
            if scope.respond_to? :all
                scope.send(:all)
            else
                scope
            end
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