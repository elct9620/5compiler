# 5compiler

module C5
  module Node
    # :nodoc:
    class Condition < Base
      def initialize(tokens)
        tokens.next # Drop `if`
        @do = nil
        @else = nil
        @expression = Expression.new(tokens)
        super
      end

      # rubocop:disable Metrics/AbcSize
      def setup
        loop do
          if t.peek.else?
            t.next
            @else = Context.new(t)
          else
            @do = Context.new(t)
          end

          break t.next if t.peek.exit?
        end
      end
      # rubocop:enable Metrics/AbcSize

      def execute(vm)
        return @do.execute(vm) if @expression.execute(vm)
        @else.execute(vm) unless @else.nil?
      end
    end
  end
end
