# 5compiler

require './nodes/base'
require './nodes/expression'
require './nodes/function'
require './nodes/assignment'
require './nodes/condition'
require './nodes/context'

module C5
  # :nodoc:
  class Parser
    attr_reader :ast

    def initialize(tokenizer)
      @tokenizer = tokenizer
      @ast = []

      parse
    end

    protected

    def parse
      tokens = @tokenizer.to_enum
      @ast = Node::Context.new(tokens).ast
    end
  end
end
