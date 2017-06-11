# frozen_string_literal: true

module C5
  module Node
    # :nodoc:
    class Base
      attr_reader :tokens

      def initialize(tokens)
        @tokens = tokens

        setup
      end

      # Awesome Print
      def pretty
        []
      end

      def name
        "#{self.class.name.split('::').last}(#{object_id})"
      end

      def execute(_vm)
        raise NotImplementedError, 'Node#execute should be implemented'
      end

      def setup
        raise NotImplementedError, 'Node#setup should be implemented'
      end

      alias t tokens
    end
  end
end
