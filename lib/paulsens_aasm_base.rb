class PaulsensAASMBase < AASM::Base
    # A custom annotation that we want available across many AASM models.
    def require_state_methods!
        klass.class_eval do
            def set_state_user(user = User.new)
                raise ArgumentError, "The user passed is invalid" unless user.class == User
                @user = user
            end
        end
    end
end