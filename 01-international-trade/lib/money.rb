require 'bigdecimal'

class Money

  attr_reader :amount, :currency

  def initialize(string_in_iso4217)
    @amount = BigDecimal.new(string_in_iso4217)
    @currency = string_in_iso4217.gsub(/[^A-Z]/, '')
  end

  def +(money)
    raise "Can't sum different currencies" if @currency != money.currency
    amount = @amount + money.amount
    Money.new("#{amount.to_s("F")} #{@currency}")
  end

  def ==(money)
    to_iso4217 == money.to_iso4217
  end

  def to_iso4217
    "#{@amount.to_s("F")} #{@currency}"
  end

end