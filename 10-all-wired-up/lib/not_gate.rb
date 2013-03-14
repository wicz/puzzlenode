class NOTGate
  include Gate

  def evaluate
    @inputs[0].to_i == 0 ? 1 : 0
  end
end