require "spec_helper"

describe Money do

  let(:money) { Money.new("42 USD") }

  context "#initialize" do
    it "parses ISO 4217 codes" do
      money.amount.should eq(42)
      money.currency.should eq('USD')
    end
  end

  context "#+" do
    it "sums amounts" do
      new_money = money + Money.new("8 USD")
      new_money.amount.should eq(50)
    end

    it "cant sum different currencies" do
      lambda { money + Money.new("10 BRL") }.should raise_error
    end
  end

  context "#to_iso4217" do
    it "prints in format ISO 4217" do
      money.to_iso4217.should eq("42.0 USD")
    end
  end

  context "#==" do
    it "compares using the ISO 4217 format" do
      money.should_receive(:to_iso4217).and_return("42.0 USD")
      money.should eq(Money.new('42 USD'))
    end
  end

end