# 5compiler

module C5
  module Node
    # :nodoc:
    class Assignment < Base
      def initialize(id, tokens)
        super tokens
        @id = id
        @expression = Expression.new(tokens)
      end

      def setup; end

      def execute(vm)
        vm.set @id.body, @expression.execute(vm)
      end
    end
  end
end
