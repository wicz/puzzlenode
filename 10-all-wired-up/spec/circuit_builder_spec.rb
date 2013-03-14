require 'spec_helper'

describe CircuitBuilder do

  before do
    @builder = CircuitBuilder.new(SIMPLE_CIRCUIT)
    @root = @builder.get_root
  end

  describe "#initialize" do
    it "splits lines from the ascii schema to work as a matrix" do
      @builder.schema_lines.size.must_equal 6
    end
  end

  describe "#get_element" do
    it "gets the element indicated by the coordinates given" do
      @builder.get_element([2, 0]).must_equal '1'
    end
  end

  describe "#get_root" do
    it "gets the position of root as [row,col]" do
      @root.must_equal [3, 27]
    end
  end

  describe "#get_left_input" do
    it "gets the position of the left input as [row, col]" do
      @builder.get_left_input(@root).must_equal [1, 14]
    end

    it "returns nil when input not found" do
      @builder.get_left_input([0, 0]).must_equal nil
    end
  end

  describe "#get_right_input" do
    it "gets the position of the right input as [row, col]" do
      @builder.get_right_input(@root).must_equal [5, 14]
    end

    it "returns nil when input not found" do
      @builder.get_right_input([0, 0]).must_equal nil
    end
  end

  describe "#build_tree" do
    it "parser the ascii schema to build a tree structure" do
      tree = @builder.build_tree
      tree.root.key.must_equal "X"
    end
  end

  describe "#circuit" do
    it "builds the circuit" do
      @builder.circuit.must_be_kind_of Circuit
    end
  end

end