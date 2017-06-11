# frozen_string_literal: true
# 5compiler

module C5
  # :nodoc:
  class Lexer < Array
    SYMBOLS       = %w[> = < ! + - / *].freeze
    KEYWORDS      = %w[if else end puts].freeze
    LINEFEED_RULE = /(?<linefeed>\n)/
    KEYWORD_RULE  = /(?<keyword>#{KEYWORDS.join('|')})/
    SYMBOL_RULE   = /(?<symbol>[#{SYMBOLS.join('')}]+)/
    STRING_RULE   = /(?<string>"[^"]+")/
    NUMBER_RULE   = /(?<number>\d+)/
    WORD_RULE     = /(?<word>\w+)/

    RULE = Regexp.union(
      LINEFEED_RULE,
      SYMBOL_RULE,
      KEYWORD_RULE,
      STRING_RULE,
      NUMBER_RULE,
      WORD_RULE
    )

    def initialize(script)
      super script.scan(RULE).flatten.compact
    end
  end
end
