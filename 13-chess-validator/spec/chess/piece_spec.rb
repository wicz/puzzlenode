require 'spec_helper'
require 'chess/piece'

describe 'Piece' do

  before do
    @board = MiniTest::Mock.new
    @piece = Chess::Piece.new(:white, :rook, @board, 'f4')
  end

  describe "#initialize" do
    it "creates a white rook at square f4 on board" do
      @piece.type.must_equal :rook
      @piece.color.must_equal :white
      @piece.board.must_equal @board
      @piece.square.must_equal 'f4'
    end
  end

  describe "#can_move?" do
    it "raises error for abstract method" do
      proc { @piece.can_move?('d1') }.must_raise RuntimeError
    end
  end

  describe "#opponent?" do
    it "is true if piece has different color" do
      bP = MiniTest::Mock.new.expect(:color, :black)
      @piece.opponent?(bP).must_equal true
    end
  end

  describe "#move" do
    before do
      @piece.instance_eval { def can_move?(to); true; end }
    end

    it "to free square" do
      @board.expect(:free, true, ['f3'])
      @piece.move('f3').must_equal true
      @piece.square.must_equal 'f3'
    end

    it "cant capture piece of same color" do
      wP = MiniTest::Mock.new.expect(:color, :white)
      @board.expect(:free, false, ['f3'])
      @board.expect(:piece_at, wP, ['f3'])
      @piece.move('f3').must_equal false
    end

    it "can capture piece of different color" do
      bP = MiniTest::Mock.new.expect(:color, :black)
      @board.expect(:free, false, ['f3'])
      @board.expect(:piece_at, bP, ['f3'])
      @piece.move('f3').must_equal true
    end

    it "cant jump over other pieces" do
      @board.expect(:free, false, ['f3'])
      @piece.move('f2').must_equal false
    end
  end

  describe "#white?" do
    it "is true if color white" do
      @piece.white?.must_equal true
    end
  end

  describe "#black?" do
    it "is true if color black" do
      @piece = Chess::Piece.new(:black, :rook, @board, 'f4')
      @piece.black?.must_equal true
    end
  end

end