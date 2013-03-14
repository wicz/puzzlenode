$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'minitest/autorun'
require 'minitest/spec'
require 'pry'

require 'circuit_builder'
require 'binary_tree'
require 'circuit'
require 'gate_factory'
require 'and_gate'
require 'gate'
require 'or_gate'
require 'not_gate'
require 'xor_gate'

def new_node(*args)
  BinaryTree::Node.new *args
end

def build_tree
  BinaryTree.new(new_node(42, new_node(40, new_node(15), new_node(25)), new_node(2)))
end

SIMPLE_CIRCUIT =<<-EOC
0-------------|
              A------------|
1-------------|            |
                           X------------@
1-------------|            |
              N------------|
EOC