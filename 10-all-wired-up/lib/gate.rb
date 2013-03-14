module Gate
  attr_accessor :name, :inputs, :output

  def initialize(*inputs)
    @inputs = inputs.flatten
  end

  def evaluate
    raise "#evaluate must be implemented in subclasses"
  end
end

