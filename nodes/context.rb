# frozen_string_literal: true

module C5
  module Node
    # :nodoc:
    class Context < Base
      attr_reader :ast

      def initialize(tokens)
        @ast = []
        super
      end

      def pretty
        Hash[@ast.map(&:name).zip(@ast.map(&:pretty))]
      end

      # rubocop:disable Metrics/AbcSize
      def setup
        loop do
          break if t.peek.else? || t.peek.exit?
          next t.next if t.peek.linefeed?
          next @ast << Node::Function.new(t) if t.peek.fn?
          next @ast << Node::Condition.new(t) if t.peek.if?
          @ast << Node::Expression.new(t)
        end
      end
      # rubocop:enable Metrics/AbcSize

      def execute(vm)
        result = nil
        @ast.each do |node|
          result = node.execute(vm)
        end
        result
      end
    end
  end
end
