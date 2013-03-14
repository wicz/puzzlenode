require 'spec_helper'

describe VigenereCipher do

  before do
    @cipher = VigenereCipher.new
    @cipher.key = 'ABLE'
  end

  describe "#initialize" do
    it "initializes caesar cipher" do
      @cipher.caesar.must_be_kind_of CaesarCipher
    end

    it "with alphabet" do
      cipher = VigenereCipher.new(%w(Q W E R T Y . = -))
      cipher.alphabet.size.must_equal 9
      cipher.caesar.alphabet.size.must_equal 9
    end
  end

  describe "#encrypt with key ABLE" do
    describe "single subject" do
      it "encrypts ATTACK to AUEECL" do
        @cipher.encrypt("ATTACK").must_equal "AUEECL"
      end
    end

    describe "complex subject" do
      it "encrypts ATTACK AT DAWN to AUEECL LX DBHR" do
        @cipher.encrypt("ATTACK AT DAWN").must_equal "AUEECL LX DBHR"
      end
    end
  end

  describe "#decrypt with key ABLE" do
    describe "single subject" do
      it "decrypts AUEECL to ATTACK" do
        @cipher.decrypt("AUEECL").must_equal "ATTACK"
      end
    end

    describe "complex subject" do
      it "decrypts AUEECL LX DBHR to ATTACK AT DAWN" do
        @cipher.decrypt("AUEECL LX DBHR").must_equal "ATTACK AT DAWN"
      end
    end
  end

end