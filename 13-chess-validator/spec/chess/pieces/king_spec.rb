require 'spec_helper'

describe 'King' do

  before do
    @board = Chess::Board.new
    @king = Chess::King.new(:white, @board, 'd4')
  end

  describe "#can_move?" do
    it "is true when vertical" do
      move = Chess::Move.new(@king.square, 'd5')
      @king.can_move?(move).must_equal true
    end

    it "is true when horizontal" do
      move = Chess::Move.new(@king.square, 'e4')
      @king.can_move?(move).must_equal true
    end

    it "is true when diagonal" do
      move = Chess::Move.new(@king.square, 'e5')
      @king.can_move?(move).must_equal true
    end

    it "only one square" do
      move = Chess::Move.new(@king.square, 'f6')
      @king.can_move?(move).must_equal false
    end

  end
end