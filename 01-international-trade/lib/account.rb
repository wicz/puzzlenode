class Account
  STORE  = 0
  SKU    = 1
  AMOUNT = 2

  def initialize(currency_exchange = CurrencyExchange.new(XMLRatesReader.new("RATES.xml")))
    @currency_exchange = currency_exchange
  end

  def sum_sales_for_product(sku)
    sum = Money.new("0 USD")
    sales.each do |sale|
      sum = sum + @currency_exchange.exchange_to(sale[AMOUNT], "USD") if sale[SKU] == sku
    end

    sum
  end
end

