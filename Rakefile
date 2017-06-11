# 5compiler

require 'awesome_print'
require './compiler'
require './vm'

GREEN = "\033[0;32m".freeze
NC = "\033[0m".freeze

EXAMPLES = Dir['examples/*.5c']

def compile(&_block)
  EXAMPLES.each do |example|
    script = File.read(example)
    compiler = C5::Compiler.new(script)
    yield example, compiler
  end
end

def filename(name)
  puts "#{GREEN}[ #{name} ]\t==========> #{NC}"
end

task default: :ast

task :words do
  compile do |example, compiler|
    filename example
    ap compiler.words
  end
end

task :tokens do
  compile do |example, compiler|
    filename example
    ap compiler.tokens
  end
end

task :ast do
  compile do |example, compiler|
    filename example
    ap compiler.ast
  end
end

task :execute do
  compile do |example, compiler|
    filename example
    C5::VM.new(compiler.ast).execute
  end
end
