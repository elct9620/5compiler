# frozen_string_literal: true

module C5
  module Node
    # :nodoc:
    class Function < Base
      def initialize(tokens)
        super

        @name = tokens.next
        @expression = Expression.new(tokens)
      end

      def pretty
        {
          function: @name.to_s,
          params: [@expression.pretty]
        }
      end

      def setup; end

      # To most simple example, direct call "puts" method in Ruby
      def execute(vm)
        value = @expression.execute(vm)
        Kernel.send @name.to_s, value
        value
      end
    end
  end
end
