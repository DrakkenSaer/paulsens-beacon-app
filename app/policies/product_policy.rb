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
        user.has_any_role?(:admin)
    end

    def update?
        user.has_any_role?(:admin)
    end

    def destroy?
        user.has_any_role?(:admin)
    end
end