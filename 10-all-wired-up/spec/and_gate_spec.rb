require 'spec_helper'

describe ANDGate do

  it "evaluates AND boolean" do
    gate = ANDGate.new
    truth_table = [
      [[0, 0], 0],
      [[0, 1], 0],
      [[1, 0], 0],
      [[1, 1], 1]
    ]
    truth_table.each do |values|
      gate.inputs = values[0]
      gate.evaluate.must_equal values[1], "for #{values[0]}"
    end
  end

end