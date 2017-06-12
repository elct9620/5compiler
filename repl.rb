# frozen_string_literal: true

require './compiler'
require './vm'

module C5
  # :nodoc:
  class Repl
    def initialize
      @vm = C5::VM.new
      @block = false
      @buffer = []
      @waiting = true
    end

    def start
      wait
      loop do
        input = gets
        parse input
        break unless @waiting
        wait
      end
    end

    protected

    def wait
      print "5c(#{@block ? 'block' : 'main'}) > "
    end

    def parse(input)
      return @waiting = false if input == "exit\n"
      return @buffer << input if block_open?(input)
      return do_block(input) if block_close?(input)
      return @buffer << input if @block
      puts @vm.execute(Compiler.new(input).ast)
    end

    def block_open?(input)
      return @block = true if input.start_with?('if')
      false
    end

    def block_close?(input)
      return false unless input.start_with?('end')
      @block = false
      true
    end

    def do_block(input)
      @buffer << input
      puts @vm.execute(Compiler.new(@buffer.join('')).ast)
      @buffer = []
    end
  end
end
