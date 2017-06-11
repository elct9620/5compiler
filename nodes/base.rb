# 5compiler

module C5
  module Node
    # :nodoc:
    class Base
      attr_reader :tokens

      def initialize(tokens)
        @tokens = tokens

        setup
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
