# 5compiler

module C5
  module Node
    # :nodoc:
    class Context < Base
      attr_reader :ast

      def initialize(tokens)
        @ast = []
        super
      end

      # rubocop:disable Metrics/AbcSize
      def setup
        loop do
          break if t.peek.else?
          next t.next if t.peek.linefeed?
          next @ast << Node::Function.new(t) if t.peek.fn?
          next @ast << Node::Condition.new(t) if t.peek.if?
          @ast << Node::Expression.new(t)
          break if t.peek.exit?
        end
      end
      # rubocop:enable Metrics/AbcSize

      def execute(vm)
        @ast.each do |node|
          node.execute(vm)
        end
      end
    end
  end
end
