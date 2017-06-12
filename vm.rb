# frozen_string_literal: true

module C5
  # :nodoc:
  class VM
    def initialize
      @variables = {}
    end

    def has?(id)
      @variables.keys.include?(id)
    end

    def get(id)
      @variables[id]
    end

    def set(id, value)
      @variables[id] = value
    end

    def execute(ast)
      result = nil
      ast.each do |node|
        result = node.execute(self)
      end
      result
    end
  end
end
