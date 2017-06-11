# frozen_string_literal: true

module C5
  # :nodoc:
  class Token
    OPERATORS = %w[+ - / *].freeze
    FUNCTIONS = %w[puts].freeze
    CONDITION = %w[== >= <= > < !=].freeze

    attr_reader :type, :body

    def initialize(type, body)
      @type = type
      @body = body
    end

    alias to_s body

    def inspect
      return @type if linefeed?
      "#{@type} (#{@body})"
    end

    def value
      return unless value?
      return body.to_i if number?
      body[1..-2]
    end

    def op
      return unless operator? || condition?
      body.to_sym
    end

    def symbol?
      type == :symbol
    end

    def keyword?
      type == :keyword
    end

    def string?
      type == :string
    end

    def number?
      type == :number
    end

    def linefeed?
      type == :linefeed
    end

    def literal?
      type == :literal
    end

    def value?
      string? || number?
    end

    def assign?
      symbol? && body == '='
    end

    def operator?
      symbol? && OPERATORS.include?(body)
    end

    def condition?
      symbol? && CONDITION.include?(body)
    end

    def fn?
      keyword? && FUNCTIONS.include?(body)
    end

    def if?
      keyword? && body == 'if'
    end

    def else?
      keyword? && body == 'else'
    end

    def exit?
      keyword? && body == 'end'
    end
  end
end
