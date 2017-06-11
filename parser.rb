# frozen_string_literal: true
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
    attr_reader :ast, :context

    def initialize(tokenizer)
      @tokenizer = tokenizer
      @context = nil
      @ast = []

      parse
    end

    protected

    def parse
      tokens = @tokenizer.to_enum
      @context = Node::Context.new(tokens)
      @ast = context.ast
    end
  end
end
