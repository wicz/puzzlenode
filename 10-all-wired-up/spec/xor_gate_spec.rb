require 'spec_helper'

describe XORGate do

  it "evaluates XOR boolean" do
    gate = XORGate.new
    truth_table = [
      [[0, 0], 0],
      [[0, 1], 1],
      [[1, 0], 1],
      [[1, 1], 0]
    ]
    truth_table.each do |values|
      gate.inputs = values[0]
      gate.evaluate.must_equal values[1], "for #{values[0]}"
    end
  end
end