# 5compiler

module C5
  module Node
    # :nodoc:
    class Function < Base
      def initialize(tokens)
        super

        @name = tokens.next
        @expression = Expression.new(tokens)
      end

      def setup; end

      # To most simple example, direct call "puts" method in Ruby
      def execute(vm)
        Kernel.send @name.to_s, @expression.execute(vm)
      end
    end
  end
end
