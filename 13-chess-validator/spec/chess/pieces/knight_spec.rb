require 'spec_helper'

describe 'Knight' do

  before do
    @knight = Chess::Knight.new(:white, nil, 'd4')
  end

  describe "#can_move?" do
    it "is true when l" do
      move = MiniTest::Mock.new
      move.expect(:l?, true)
      @knight.can_move?(move)
      move.verify
    end
  end
end