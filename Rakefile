# 5compiler

require 'awesome_print'
require './compiler'
require './vm'

GREEN = "\033[0;32m".freeze
RED = "\033[0;31m".freeze
NC = "\033[0m".freeze

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

task default: :ast

task :words do
  compile do |example, script, compiler|
    filename example
    source script
    ap compiler.words
  end
end

task :tokens do
  compile do |example, script, compiler|
    filename example
    source script
    ap compiler.tokens
  end
end

task :ast do
  compile do |example, script, compiler|
    filename example
    source script
    ap compiler.ast
  end
end

task :execute do
  compile do |example, script, compiler|
    filename example
    source script
    C5::VM.new(compiler.ast).execute
  end
end
