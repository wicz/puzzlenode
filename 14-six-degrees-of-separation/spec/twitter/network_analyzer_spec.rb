require 'spec_helper'

describe "NetworkAnalyzer" do

  before do
    @mention = "john: Unbeliable @jane, he looked at me and shouted: I'LL KILL YA! /cc @achmed"
    @analyzer = Twitter::NetworkAnalyzer.new
  end

  describe "#extract_speaker" do
    it "returns the name before de first colon" do
      @analyzer.extract_speaker(@mention).must_equal 'john'
    end
  end

  describe "#extract_listeners" do
    it "returns all the users before the first colon" do
      @analyzer.extract_listeners(@mention).must_equal %w{ jane achmed }
    end
  end
end