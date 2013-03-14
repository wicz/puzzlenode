class BinaryTree
  attr_accessor :root

  def initialize(root)
    @root = root
  end

  def traverse_preorder(root = @root)
    return unless root
    [root.key, traverse_preorder(root.left), traverse_preorder(root.right)]
  end

  def prefix_notation
    traverse_preorder.flatten.compact
  end

  class Node
    attr_accessor :key, :left, :right

    def initialize(key = nil, left = nil, right = nil)
      @key   = key
      @left  = left
      @right = right
    end
  end
end

