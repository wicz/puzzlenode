class CurrencyExchange

  attr_accessor :reader, :rates

  def initialize(rates_reader)
    @reader = rates_reader
    @rates = @reader.read_rates
  end

  def exchange_to(money, currency)
    amount = money.amount * @rates[money.currency][currency]
    Money.new("#{amount} #{currency}")
  end

  def currencies
    currencies = @rates.keys
    @rates.each do |key, value|
      currencies |= value.keys
    end
    currencies
  end

  def fill_missing_currencies
    # filling columns
    currencies.each do |item|
      @rates[item] = {} unless @rates.key? item
    end
    # filling rows
    currencies.each do |item|
      @rates.each do |key, value|
        value[item] = nil unless value.key?(item) || key == item
      end
    end
  end

  def derive_explicit_blank_rates
    fill_missing_currencies
    @rates.each do |from, currencies|
      currencies.each do |to, rate|
        @rates[to][from] ||= (1 / rate) if rate
      end
    end
  end

  def derive_implicit_blank_rates
    derive_explicit_blank_rates
    @rates.each do |from, currencies|
      currencies.each do |to, rate|
        if rate.nil?
          exchange_path = [to]
          non_visited_currencies = get_all_currencies - exchange_path

          while exchange_path.first != from || non_visited_currencies.empty?
            prev_currency = non_visited_currencies.detect { |currency| @rates[currency][to] != nil }
            if prev_currency
              exchange_path.unshift prev_currency
              non_visited_currencies.delete prev_currency
            end
          end

        end
      end
    end
  end
end

