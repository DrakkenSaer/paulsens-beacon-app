module Helpers::ResourceStateHelper
  
    def states_list(klass = self.class)
      klass::STATES
    end

    # Helper methods for managing resource states
    def valid_state?(state = :'')
        states_list.include?(state.to_sym)
    end

    def state_completed?(min_state, max_state = self.aasm.current_state)
        min = states_list.index(min_state.to_sym)
        max = states_list.index(max_state.to_sym)
        max > min
    end

    def current_state?(state, current_state = self.aasm.current_state)
        current_state == state.to_sym
    end

    def interacting_with_state?(state, current_state = self.aasm.current_state)
        raise ArgumentError, "The state passed is invalid" unless valid_state?(state) && valid_state?(current_state)
        current_state?(state, current_state) || state_completed?(state, current_state)
    end

    def set_state_user(user = User.new)
        raise ArgumentError, "The user passed is invalid" unless user.class == User
        @user = user
    end

    # Figure out a good way to test for state transitions
    def transitioning_to_problem_state?
        resource_state == 'problem'
    end

end
