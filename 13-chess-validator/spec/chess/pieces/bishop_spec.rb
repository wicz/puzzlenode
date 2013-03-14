require 'spec_helper'

describe 'Bishop' do

  before do
    @bishop = Chess::Bishop.new(:white, nil, 'd4')
  end

  describe "#can_move?" do
    it "is true when diagonal" do
      move = MiniTest::Mock.new
      move.expect(:diagonal?, true)
      @bishop.can_move?(move)
      move.verify
    end
  end
end