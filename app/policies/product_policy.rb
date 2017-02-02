class ProductPolicy < ApplicationPolicy
    class Scope < Scope
        def resolve
            true
        end
    end
    
    def index?
        true
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