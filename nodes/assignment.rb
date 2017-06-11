# frozen_string_literal: true

module C5
  module Node
    # :nodoc:
    class Assignment < Base
      def initialize(id, tokens)
        super tokens
        @id = id
        @expression = Expression.new(tokens)
      end

      def pretty
        {
          id: @id.to_s,
          value: @expression.pretty
        }
      end

      def setup
        t.next
      end

      def execute(vm)
        vm.set @id.body, @expression.execute(vm)
      end
    end
  end
end
