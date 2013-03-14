require 'spec_helper'

describe 'Pawn' do

  before do
    @board = MiniTest::Mock.new
    @pawn = Chess::Pawn.new(:white, @board, 'a2')
  end

  describe "#can_move?" do
    describe "when white" do
      it "only moves up" do
        move = Chess::Move.new(@pawn.square, 'a1')
        @pawn.can_move?(move).must_equal false
      end
    end

    describe "black" do
      it "only moves down" do
        @pawn = Chess::Pawn.new(:black, nil, 'a3')
        move = Chess::Move.new(@pawn.square, 'a5')
        @pawn.can_move?(move).must_equal false
      end
    end

    it "is true when vertical" do
      move = Chess::Move.new(@pawn.square, 'a3')
      @pawn.can_move?(move).must_equal true
    end

    it "two squares if first move" do
      move = Chess::Move.new(@pawn.square, 'a4')
      @pawn.can_move?(move).must_equal true
    end

    it "is false if more than one square" do
      @pawn = Chess::Pawn.new(:white, nil, 'a3')
      move = Chess::Move.new(@pawn.square, 'a5')
      @pawn.can_move?(move).must_equal false
    end

    it "diagonally to capture" do
      bP = Chess::Pawn.new(:blank, nil, 'b3')
      @board.expect(:piece_at, bP, ['b3'])
      move = Chess::Move.new(@pawn.square, 'b3')
      @pawn.can_move?(move).must_equal true
    end

  end
end