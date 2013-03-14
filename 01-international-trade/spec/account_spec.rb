require "spec_helper"

describe Account do
  before(:each) do
    @changer = mock(:currency_exchange)
    @account = Account.new(@changer)
    @account.stub(:sales => [
      ['Yonkers',   'DM1210', Money.new('70.00 USD')],
      ['Scranton',  'DM1210', Money.new('68.76 USD')],
      ['Yonkers',   'DM1182', Money.new('19.68 AUD')],
      ['Nashua',    'DM1182', Money.new('58.58 AUD')],
      ['Camden',    'DM1182', Money.new('54.64 USD')]
    ])
  end

  describe "#sum_sales_for_product" do
    it "sums specified product" do
      @changer.should_receive(:exchange_to).twice.and_return(Money.new('70.00 USD'), Money.new('68.76 USD'))
      @account.sum_sales_for_product('DM1210').should eq(Money.new("138.76 USD"))
    end

    it "with different currency" do
      pending
      @changer.should_receive(:exchange_to).exactly(3).and_return(Money.new('20.01 USD'), Money.new('59.57 USD'), Money.new('54.64 USD'))
      @account.sum_sales_for_product('DM1182').should eq(Money.new('134.22 USD'))
    end
  end
end

