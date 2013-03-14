require 'spec_helper'

describe Gate do

  class DummyGate; include Gate; end

  before do
    @gate = DummyGate.new
  end

  it "can initialize with inputs" do
    @gate = DummyGate.new(0,1)
    @gate.inputs.must_equal [0,1]
  end

  it "has accessors for name, inputs and output" do
    %w(name inputs output).each do |m|
      @gate.must_respond_to m
    end
  end

  it "must implement the evaluate method" do
    lambda { @gate.evaluate }.must_raise RuntimeError
  end

end