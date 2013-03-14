class Circuit
  attr_accessor :prefix_notation, :scheme_tree

  def initialize(tree)
    @scheme_tree = tree
  end

  def prefix_notation
    @scheme_tree.prefix_notation
  end

  def evaluate
    states = []
    prefix_notation.reverse.each do |node|
      if GateFactory::GATES.include?(node)
        inputs = states.shift (node == "N" ? 1 : 2)
        gate = GateFactory.create(node, inputs)
        states.unshift gate.evaluate
      else
        states.unshift node
      end
    end

    states.first
  end
end

