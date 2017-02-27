class OrderPolicy < ApplicationPolicy
    class Scope < Scope
        def resolve
            if is_admin?
                if scope.respond_to? :all
                    scope.send(:all)
                else
                    scope
                end
            else
                scope.where(user: user)
            end
        end
    end
    
    def create?
        true 
    end

    def update?
        is_admin?
    end

    def destroy?
        is_admin?
    end
end