require 'spec_helper'

describe "Network" do

  before do
    @network = Twitter::Network.new
  end

  describe "#initialize" do
    it "can be initialized with connections list" do
      mentions = {'a' => %w{ b c }, 'b' => %w{ a }, 'c' => %w{ b } }
      network = Twitter::Network.new(mentions)
      network.neighbours('a').must_equal %w{ b c }
      network.neighbours('b').must_equal %w{ a }
      network.neighbours('c').must_equal %w{ b }
    end
  end

  describe "#neighbours" do
    it "return one's connections" do
      @network.add_connection('bob', 'alberta')
      @network.neighbours('bob').must_include 'alberta'
    end

    it "is empty if user has no connections" do
      @network.neighbours('bob').must_be_empty
    end
  end

  describe "#add_connection" do
    it "add connection from bob to alberta" do
      @network.add_connection('bob', 'alberta')
      @network.neighbours('bob').must_include 'alberta'
    end

    it "should not duplicate connections" do
      2.times { @network.add_connection('bob', 'alberta') }
      @network.neighbours('bob').size.must_equal 1
    end

    it "add one-way connection" do
      @network.add_connection('bob', 'alberta')
      @network.neighbours('alberta').must_be_empty
    end
  end

  describe "#remove_noise" do
    it "removes noise and the related one-way connection" do
      @network.add_connection('bob', 'alberta')
      @network.remove_noise
      @network.neighbours('bob').must_be_empty
    end
  end

  describe "#connections_degrees" do
    before do
      list = {
        'a' => %w{ b c d },
        'b' => %w{ a c d },
        'c' => %w{ a b e },
        'd' => %w{ b e f },
        'e' => %w{ d c },
        'f' => %w{ d }
      }
      @degrees = Twitter::Network.new(list).connections_degrees
    end

    describe "for a" do
      it "first order are b and c" do
        @degrees['a'][1].must_equal %w{ b c }
      end

      it "second order is d" do
        @degrees['a'][2].must_equal %w{ d e }
      end

      it "third order is f" do
        @degrees['a'][3].must_equal %w{ f }
      end
    end
  end

end