require 'spec_helper'

describe "Board" do

  before do
    @piece = MiniTest::Mock.new
    @board = Chess::Board.new({'a1' => @piece})
  end

  describe "#piece_at" do
    it "returns the piece at the given position" do
      @board.piece_at('a1').must_equal @piece
    end

    it "returns nil when position invalid" do
      @board.piece_at('z0').must_be_nil
    end

    it "returns nil if there isnt a piece at the given position" do
      @board.piece_at('a2').must_be_nil
    end
  end

  describe "#valid_squares?" do
    it "returns true if all positions inside board" do
      @board.valid_squares?('a1', 'b1', 'c1').must_equal true
    end

    it "returns false if position outside the board" do
      @board.valid_squares?('a1', 'b1', 'p1').must_equal false
    end
  end

  describe "#free" do
    it "is true if square has no piece on it" do
      @board.free('a2').must_equal true
      @board.free('a1').must_equal false
    end
  end

  describe "#move" do
    before do
      @piece.expect(:move, true, ['d1'])
    end

    it "cant move to same square" do
      @board.move('a1', 'a1').must_equal false
    end

    it "cant move from/to invalid squares" do
      @board.move('a1', 'z1').must_equal false
    end

    it "cant move if there's no piece" do
      @board.move('a2', 'a3').must_equal false
    end

    it "moves piece from a1 to d1" do
      @board.move('a1', 'd1')
      @board.piece_at('a1').must_be_nil
      @board.piece_at('d1').must_equal @piece
      @piece.verify
    end
  end

  describe "#has_piece?" do
    it "is true if square is not free" do
      @board.has_piece?('a1').must_equal true
      @board.has_piece?('a2').must_equal false
    end
  end

  describe "#walk" do
    it "left" do
      @board.walk('f5', :left).must_equal %w{ f5 e5 d5 c5 b5 a5 }
    end

    it "right" do
      @board.walk('f5', :right).must_equal %w{ f5 g5 h5 }
    end

    it "up" do
      @board.walk('f5', :up).must_equal %w{ f5 f6 f7 f8 }
    end

    it "down" do
      @board.walk('f5', :down).must_equal %w{ f5 f4 f3 f2 f1 }
    end

    it "up and right" do
      @board.walk('f5', :upright).must_equal %w{ f5 g6 h7 }
    end

    it "up and left" do
      @board.walk('f5', :upleft).must_equal %w{ f5 e6 d7 c8 }
    end

    it "down and right" do
      @board.walk('f5', :downright).must_equal %w{ f5 g4 h3 }
    end

    it "down and left" do
      @board.walk('f5', :downleft).must_equal %w{ f5 e4 d3 c2 b1 }
    end
  end

  describe "#l_squares_from" do
    describe "gets the squares one can get in L-shape move starting from" do
      it "d3" do
        squares = @board.l_squares_from('d3')
        squares.sort.must_equal %w{ c1 e1 b2 f2 b4 f4 c5 e5 }.sort
      end

      it "b1" do
        squares = @board.l_squares_from('b1')
        squares.sort.must_equal %w{ a3 c3 d2 }.sort
      end
    end
  end

  describe "#check?" do
    before do
      @wK = MiniTest::Mock.new
      @wK.expect(:color, :white)
      @wK.expect(:square, 'f5')
    end

    describe "is true when threatened" do
      before do
        @wK.expect(:opponent?, true, [Object])
      end

      it "perpendicularly by rook" do
        wR = Chess::Rook.new(:white, @board, 'f7')
        @board.pieces['f7'] = wR
        @board.check?(@wK).must_equal true
      end

      it "perpendicularly by queen" do
        wQ = Chess::Queen.new(:white, @board, 'a5')
        @board.pieces['a5'] = wQ
        @board.check?(@wK).must_equal true
      end

      it "diagonally by bishop" do
        wB = Chess::Bishop.new(:white, @board, 'd3')
        @board.pieces['d3'] = wB
        @board.check?(@wK).must_equal true
      end

      it "diagonally by queen" do
        wQ = Chess::Queen.new(:white, @board, 'b1')
        @board.pieces['b1'] = wQ
        @board.check?(@wK).must_equal true
      end

      it "diagonally by pawn" do
        wP = Chess::Pawn.new(:white, @board, 'e4')
        @board.pieces['e4'] = wP
        @board.check?(@wK).must_equal true
      end

      it "by knight" do
        wN = Chess::Knight.new(:white, @board, 'd4')
        @board.pieces['d4'] = wN
        @board.check?(@wK).must_equal true
      end
    end

  end

end