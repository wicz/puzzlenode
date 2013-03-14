require "spec_helper"

describe "Move" do
  describe "#up?" do
    it "is true when move is upwards" do
      move = Chess::Move.new('a1', 'a4')
      move.up?.must_equal true
    end

    it "is false when move not upwards" do
      move = Chess::Move.new('a4', 'a1')
      move.up?.must_equal false
    end
  end

  describe "#down?" do
    it "is true when move downwards" do
      move = Chess::Move.new('a4', 'a1')
      move.down?.must_equal true
    end

    it "is false when move not downwards" do
      move = Chess::Move.new('a4', 'd4')
      move.down?.must_equal false
    end
  end

  describe "#left?" do
    it "is true when move towards left" do
      move = Chess::Move.new('d4', 'b4')
      move.left?.must_equal true
    end

    it "is false when move not left" do
      move = Chess::Move.new('d4', 'e4')
      move.left?.must_equal false
    end
  end

  describe "#right?" do
    it "is true when move towards right" do
      move = Chess::Move.new('a1', 'c1')
      move.right?.must_equal true
    end

    it "is false when move not right" do
      move = Chess::Move.new('c1', 'a1')
      move.right?.must_equal false
    end
  end

  describe "#vertical?" do
    it "is true when move up" do
      move = Chess::Move.new('a1', 'a3')
      move.vertical?.must_equal true
    end

    it "is true when move down" do
      move = Chess::Move.new('a3', 'a1')
      move.vertical?.must_equal true
    end

    it "is false when change file" do
      move = Chess::Move.new('a1', 'b5')
      move.vertical?.must_equal false
    end
  end

  describe "#horizontal?" do
    it "is true when move left" do
      move = Chess::Move.new('f4', 'a4')
      move.horizontal?.must_equal true
    end

    it "is true when move right" do
      move = Chess::Move.new('a4', 'f4')
      move.horizontal?.must_equal true
    end

    it "is false when change rank" do
      move = Chess::Move.new('a4', 'f7')
      move.horizontal?.must_equal false
    end
  end

  describe "#diagonal?" do
    it "is true when same distance for rank and file" do
      move = Chess::Move.new('a1', 'c3')
      move.diagonal?.must_equal true
    end
  end

  describe "#l?" do
    it "is true when two squares horizontally and one vertically" do
      ['e1', 'c1', 'e5', 'c5'].each do |to|
        move = Chess::Move.new('d3', to)
        move.l?.must_equal true
      end
    end

    it "it true when two squares vertically and one horizontally" do
      ['b2', 'f2', 'b4', 'f4'].each do |to|
        move = Chess::Move.new('d3', to)
        move.l?.must_equal true
      end
    end
  end

  describe "#path" do
    describe "vertical" do
      it "up" do
        move = Chess::Move.new('a1', 'a5')
        move.path.must_equal %w{ a2 a3 a4 }
      end

      it "down" do
        move = Chess::Move.new('a5', 'a1')
        move.path.must_equal %w{ a4 a3 a2 }
      end
    end

    describe "horizontal" do
      it "right" do
        move = Chess::Move.new('a1', 'd1')
        move.path.must_equal %w{ b1 c1 }
      end

      it "left" do
        move = Chess::Move.new('f5', 'a5')
        move.path.must_equal %w{ e5 d5 c5 b5 }
      end
    end

    describe "diagonal" do
      it "up right" do
        move = Chess::Move.new('d5', 'g8')
        move.path.must_equal %w{ e6 f7 }
      end

      it "up left" do
        move = Chess::Move.new('d5', 'a8')
        move.path.must_equal %w{ c6 b7 }
      end

      it "down right" do
        move = Chess::Move.new('d5', 'h1')
        move.path.must_equal %w{ e4 f3 g2 }
      end

      it "down left" do
        move = Chess::Move.new('d5', 'a2')
        move.path.must_equal %w{ c4 b3 }
      end
    end

    it "l" do
      %w{ e6 f5 f3 e2 c2 b3 b5 c6 }.each do |to|
        move = Chess::Move.new('d4', to)
        move.path.must_equal [], to
      end
    end

    it "cant move one forward" do
      move = Chess::Move.new('e4', 'e5')
      move.l?.must_equal false
    end

    describe "#valid?" do
      it "is true when vertical" do
        move = Chess::Move.new('d4', 'd7')
        move.valid?.must_equal true
      end

      it "is true when horizontal" do
        move = Chess::Move.new('d4', 'e4')
        move.valid?.must_equal true
      end

      it "is true when diagonal" do
        move = Chess::Move.new('d4', 'e5')
        move.valid?.must_equal true
      end

      it "is true when l" do
        move = Chess::Move.new('d4', 'f5')
        move.valid?.must_equal true
      end

      it "is false when move not a valid chess move" do
        move = Chess::Move.new('a2', 'b7')
        move.valid?.must_equal false
      end
    end

  end

end
