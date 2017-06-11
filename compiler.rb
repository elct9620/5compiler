# frozen_string_literal: true
# 5compiler

require './lexer'
require './tokenizer'
require './parser'

module C5
  # :nodoc:
  class Compiler
    attr_reader :words, :tokenizer, :parser

    def initialize(script)
      @words = Lexer.new(script)
      @tokenizer = Tokenizer.new(words)
      @parser = Parser.new(tokenizer)
    end

    def tokens
      tokenizer.to_a
    end

    def ast
      parser.ast
    end
  end
end
