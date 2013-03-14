class CircuitBuilder
  attr_reader :schema_lines

  def initialize(schema_ascii)
    @schema_lines = schema_ascii.split(/\n/)
  end

  def circuit
    Circuit.new(build_tree)
  end

  def get_root
    line = @schema_lines.detect { |l| l.include?('@') }
    row = @schema_lines.index(line)
    col = line.size - line[/[#{GateFactory::GATES.join}]-+@/].size
    [row, col]
  end

  def get_element(coord)
    @schema_lines[coord[0]][coord[1]] rescue nil
  end

  def get_left_input(source)
    row, col = source[0], source[1]
    return nil if get_element([row-1, col]) != '|'
    row -= 1 while get_element([row-1, col]) == '|'
    col -= 1
    col -= 1 while get_element([row, col]) == '-'
    [row, col]
  end

  def get_right_input(source)
    row, col = source[0], source[1]
    return nil if get_element([row+1, col]) != '|'
    row += 1 while get_element([row+1, col]) == '|'
    col -= 1
    col -= 1 while get_element([row, col]) == '-'
    [row, col]
  end

  def preorder_copy(src, dst)
    key = get_element(src)
    return if key.nil?
    dst.key = key
    left, right = get_left_input(src), get_right_input(src)
    preorder_copy(left, dst.left = BinaryTree::Node.new) if left
    preorder_copy(right, dst.right = BinaryTree::Node.new) if right
  end

  def build_tree
    root = BinaryTree::Node.new
    preorder_copy(get_root, root)
    BinaryTree.new(root)
  end
end

