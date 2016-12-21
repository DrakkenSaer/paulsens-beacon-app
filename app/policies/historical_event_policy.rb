class HistoricalEventPolicy < ApplicationPolicy
    class Scope < Scope
        def resolve
            scope.all
        end
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