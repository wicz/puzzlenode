require 'spec_helper'

describe "PieceFactory" do

  before do
    @piece_factory = Chess::PieceFactory.new
  end

  describe "#new_piece" do
    it "builds white pawns" do
      piece = @piece_factory.new_piece('wP', nil, nil)
      piece.must_be_instance_of Chess::Pawn
      piece.color.must_equal :white
    end
  end

  describe "#color_from_notation" do
    it "returns white for wP" do
      @piece_factory.color_from_notation('wP').must_equal :white
    end

    it "return black for bP" do
      @piece_factory.color_from_notation('bP').must_equal :black
    end

    it "raises if not black or white" do
      proc { @piece_factory.color_from_notation('gP') }.must_raise RuntimeError
    end
  end

  describe "#type_from_notation" do
    it "returns the class for the known types" do
      {'R' => Chess::Rook, 'B' => Chess::Bishop, 'N' => Chess::Knight, 'Q' => Chess::Queen, 'K' => Chess::King, 'P' => Chess::Pawn}.each do |type, klass|
        @piece_factory.type_from_notation("w#{type}").must_equal klass
      end
    end

    it "raises error when unknown type" do
      proc { @piece_factory.type_from_notation('wZ') }.must_raise RuntimeError
    end
  end


end