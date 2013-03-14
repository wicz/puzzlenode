require 'spec_helper'

describe 'Rook' do

  before do
    @rook = Chess::Rook.new(:white, nil, 'a1')
  end

  describe "#can_move?" do
    it "is true when vertical" do
      move = MiniTest::Mock.new
      move.expect(:vertical?, true)
      @rook.can_move?(move)
      move.verify
    end

    it "is true when horizontal" do
      move = MiniTest::Mock.new
      move.expect(:vertical?, false)
      move.expect(:horizontal?, true)
      @rook.can_move?(move)
      move.verify
    end
  end
end