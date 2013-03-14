class ORGate
  include Gate

  def evaluate
    @inputs[0].to_i | @inputs[1].to_i
  end
end