# frozen_string_literal: true

require 'awesome_print'
require 'mrdialog'
require './compiler'
require './vm'
require './repl'

GREEN = "\033[0;32m"
RED = "\033[0;31m"
NC = "\033[0m"

EXAMPLES = Dir['examples/*.5c']

def compile(&_block)
  EXAMPLES.each do |example|
    script = File.read(example)
    compiler = C5::Compiler.new(script)
    yield example, script, compiler
  end
end

def filename(name)
  puts "#{GREEN}[ #{name} ]\t==========> #{NC}"
end

def source(script)
  puts nil
  puts "#{RED}#{script}#{NC}"
end

task default: :interactive

desc 'Interactive mode'
task :interactive do
  C5::Repl.new.start
end

desc 'Show words compiler scanned'
task :words do
  compile do |example, script, compiler|
    filename example
    source script
    ap compiler.words
  end
end

desc 'Show tokens compiler marked'
task :tokens do
  compile do |example, script, compiler|
    filename example
    source script
    ap compiler.tokens
  end
end

desc 'Show ast compiler converted'
task :ast do
  compile do |example, script, compiler|
    filename example
    source script
    ap compiler.parser.context.pretty
  end
end

desc 'Execute all examples'
task :execute do
  compile do |example, script, compiler|
    filename example
    source script
    C5::VM.new.execute(compiler.ast)
  end
end
