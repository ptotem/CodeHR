module StateMachine
  module Integrations
    module ActiveModel
      send :public, :around_validation
    end
  end
end
