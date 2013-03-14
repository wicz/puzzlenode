require 'spec_helper'

describe BinaryTree do
  describe "#initialize" do
    it "needs root" do
      tree = BinaryTree.new(new_node(42))
      tree.root.key.must_equal 42
    end
  end

  describe "#prefix_notation" do
    it "returns nodes in prefix notation" do
      tree = build_tree
      tree.prefix_notation.must_equal [42, 40, 15, 25, 2]
    end
  end
end

describe BinaryTree::Node do

  describe "#initialize" do
    it "can accept initial key" do
      node = BinaryTree::Node.new(42)
      node.key.must_equal 42
    end
  end

  it "has attribute accessors for key, left and right" do
    node = BinaryTree::Node.new
    %w(key key= left left= right right=).each do |m|
      node.respond_to?(m).must_equal true
    end
  end
end