require 'spec_helper'

describe GateFactory do

  describe "#create" do
    it "creates AND gate" do
      gate = GateFactory.create('A')
      gate.must_be_kind_of(ANDGate)
    end

    it "creates OR gate" do
      gate = GateFactory.create('O')
      gate.must_be_kind_of(ORGate)
    end

    it "creates XOR gate" do
      gate = GateFactory.create('X')
      gate.must_be_kind_of(XORGate)
    end

    it "creates NOT gate" do
      gate = GateFactory.create('N')
      gate.must_be_kind_of(NOTGate)
    end

    it "creates gate with inputs" do
      gate = GateFactory.create('O', 1, 0)
      gate.inputs.must_equal [1, 0]
    end
  end



end