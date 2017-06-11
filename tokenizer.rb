# 5compiler

require './lexer'
require './token'

module C5
  # :nodoc:
  class Tokenizer
    include Enumerable

    MATCH_RULES = {
      linefeed: Lexer::LINEFEED_RULE,
      symbol:   Lexer::SYMBOL_RULE,
      keyword:  Lexer::KEYWORD_RULE,
      string:   Lexer::STRING_RULE,
      number:   Lexer::NUMBER_RULE
    }.freeze

    def initialize(words)
      @words = words
    end

    def each(&_block)
      return enum_for(:each) unless block_given?

      @words.map do |word|
        yield tokenize(word)
      end
    end

    protected

    def tokenize(word)
      MATCH_RULES.each do |type, rule|
        return Token.new(type, word) if word =~ rule
      end

      Token.new(:literal, word)
    end
  end
end
