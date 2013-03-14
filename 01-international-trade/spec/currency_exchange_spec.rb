require "spec_helper"

describe CurrencyExchange do
  let(:changer) do
    reader = mock(:rates_reader, :read_rates => {
      'USD' => { 'BRL' => 1.5, 'AUD' => 1.1 }
    })
    CurrencyExchange.new(reader)
  end

  context "#exchange_to" do
    it "exchanges 100 USD to 150 BRL" do
      money = changer.exchange_to(Money.new('100 USD'), 'BRL')
      money.amount.should eq(150)
      money.currency.should eq('BRL')
    end
  end

  context "#get_all_currencies" do
    it "returns all currencies from columns and rows" do
      changer.get_all_currencies.should eq(%w(USD BRL AUD))
    end
  end

  context "#fill_missing_currencies" do
    it "creates a table with all exchanges combinations" do
      currencies = %w(USD BRL AUD)
      changer.fill_missing_currencies
      changer.rates.keys.should eq(currencies)
      currencies.each do |item|
        changer.rates[item].keys.should eq(currencies - [item])
      end
    end
  end

  context "derive blank rates" do
    context "#derive_explicit_blank_rates" do
      it "calculates BRL->USD and AUD->USD" do
        changer.derive_explicit_blank_rates
        changer.rates['BRL']['USD'].should eq(1 / changer.rates['USD']['BRL'])
        changer.rates['AUD']['USD'].should eq(1 / changer.rates['USD']['AUD'])
      end
    end

    context "#derive_implicit_blank_rates" do
      it "calculates BRL->AUD and AUD->BRL" do
        changer.derive_implicit_blank_rates
        changer.rates['BRL']['AUD'].should eq(changer.rates['BRL']['USD'] * changer.rates['USD']['AUD'])
      end
    end
  end
end

