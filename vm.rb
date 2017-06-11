# 5compiler

module C5
  # :nodoc:
  class VM
    def initialize(ast)
      @variables = {}
      @ast = ast
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

    def execute
      @ast.each do |node|
        node.execute(self)
      end
    end
  end
end
