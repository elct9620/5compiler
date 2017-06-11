# 5compiler

module C5
  module Node
    # :nodoc:
    class Expression < Base
      def initialize(tokens)
        @nodes = []
        @assignments = []

        super
      end

      def setup
        loop do
          @nodes << t.next
          break @assignments << Assignment.new(@nodes.pop, t) if assign?
          break t.next if t.peek.linefeed?
        end
      end

      # Expression always chain call method
      def execute(vm)
        do_assignment(vm)

        nodes = @nodes.to_enum
        result = pick_value(nodes, vm)

        loop do
          op = pick_operator(nodes)
          value = pick_value(nodes, vm)
          break if op.nil? || value.nil?
          result = result.send(op, value)
        end

        result
      end

      protected

      def assign?
        t.peek.assign?
      end

      def do_assignment(vm)
        @assignments.each do |node|
          node.execute(vm)
        end
      end

      def pick_value(nodes, vm)
        loop do
          return nodes.next.value if nodes.peek.value?
          return variable(vm, nodes.next) if variable?(vm, nodes.peek)
          nodes.next
        end
        nil
      rescue StopIteration
        raise RuntimeError
      end

      def pick_operator(nodes)
        loop do
          return nodes.next.op if nodes.peek.operator? || nodes.peek.condition?
          nodes.next
        end
        nil
      rescue StopIteration
        raise RuntimeError
      end

      def variable(vm, node)
        vm.get(node.body)
      end

      def variable?(vm, node)
        vm.has?(node.body) && node.literal?
      end
    end
  end
end
