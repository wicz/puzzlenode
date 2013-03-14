require 'spec_helper'

describe CaesarCipher do

  before do
    @cipher = CaesarCipher.new
  end

  describe "#initialize" do
    it "with alphabet" do
      cipher = CaesarCipher.new(%w(Q W E R T Y . = -))
      cipher.alphabet.size.must_equal 9
    end
  end

  describe "#encrypt" do
    describe "single subject" do
      it "fails if key not found" do
        lambda { @cipher.encrypt("A", "0") }.must_raise RuntimeError
      end

      it "returns the same letter when key is the first of the alphabet (shift=0)" do
        @cipher.encrypt("F", "A").must_equal "F"
      end

      it "returns E for B when key is D (shift=3)" do
        @cipher.encrypt("B", "D").must_equal "E"
      end

      it "cycle the alphabet on last letter" do
        @cipher.encrypt("Z", "B").must_equal "A"
      end

      it "returns the same character when not in alphabet" do
        @cipher.encrypt('.', 'A').must_equal '.'
      end
    end

    describe "complex subject with key D" do
      it "encrypts COWARDS to FRZDUGV" do
        @cipher.encrypt("COWARDS", "D").must_equal "FRZDUGV"
      end
    end

    it "encrypts COWARDS DIE MANY TIMES BEFORE THEIR DEATHS to FRZDUGV GLH PDQB WLPHV EHIRUH WKHLU GHDWKV" do
      @cipher.encrypt("COWARDS DIE MANY TIMES BEFORE THEIR DEATHS", "D").must_equal "FRZDUGV GLH PDQB WLPHV EHIRUH WKHLU GHDWKV"
    end
  end

  describe "#decrypt" do
    describe "single subject" do
      it "fails if key not found" do
        lambda { @cipher.decrypt("A", "0") }.must_raise RuntimeError
      end

      it "returns the same letter when key is the first of the alphabet" do
        @cipher.decrypt("F", "A").must_equal "F"
      end

      it "returns B for E when key is D (shift=3)" do
        @cipher.decrypt("E", "D").must_equal "B"
      end

      it "cycle the alphabet on first letter" do
        @cipher.decrypt("A", "B").must_equal "Z"
      end
    end

    describe "complex subject with key D" do
      it "decrypts FRZDUGV to COWARDS" do
        @cipher.decrypt("FRZDUGV", "D").must_equal "COWARDS"
      end
    end

    it "decrypts FRZDUGV GLH PDQB WLPHV EHIRUH WKHLU GHDWKV to COWARDS DIE MANY TIMES BEFORE THEIR DEATHS" do
      @cipher.decrypt("FRZDUGV GLH PDQB WLPHV EHIRUH WKHLU GHDWKV", "D").must_equal "COWARDS DIE MANY TIMES BEFORE THEIR DEATHS"
    end
  end

end