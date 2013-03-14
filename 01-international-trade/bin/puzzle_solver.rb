require "account"
require "currency_exchange"
require "money"
require "xml_rates_reader"

class PuzzleSolver
  def self.solve
    account = Account.new(CurrencyExchange.new(XMLRatesReader.new('RATES.xml')))
    puts account.sum_sales_for_product("DM1182")
  end
end

PuzzleSolver.solve

