require 'spec_helper'

describe Circuit do

  before do
    @tree = MiniTest::Mock.new
    @circuit = Circuit.new(@tree)
  end

  it "evaluates to zero" do
    @tree.expect(:prefix_notation, %w(O 0 1))
    @circuit.evaluate.must_equal 1
  end

  it "evaluates to zero" do
    @tree.expect(:prefix_notation, %w(X A 0 1 N 1))
    @circuit.evaluate.must_equal 0
  end

  it "evaluates to one" do
    @tree.expect(:prefix_notation, %w(X O 0 1 X 1 1))
    @circuit.evaluate.must_equal 1
  end

end