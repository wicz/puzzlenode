require 'spec_helper'

describe 'Queen' do

  before do
    @queen = Chess::Queen.new(:white, nil, 'd4')
  end

  describe "#can_move?" do
    it "is true when vertical" do
      move = Chess::Move.new(@queen.square, 'd5')
      @queen.can_move?(move).must_equal true
    end

    it "is true when horizontal" do
      move = Chess::Move.new(@queen.square, 'e4')
      @queen.can_move?(move).must_equal true
    end

    it "is true when diagonal" do
      move = Chess::Move.new(@queen.square, 'e5')
      @queen.can_move?(move).must_equal true
    end

  end
end