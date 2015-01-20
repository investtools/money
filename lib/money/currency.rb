require 'money/money'

class Money
  class Currency < Struct.new(:id)

    def self.exchange(&block) 
      @@exchange_handler = block
    end

    def self.[](currency)
      return currency if currency.kind_of?(self)
      Currency.new(currency)
    end

    def to(other_currency, on:)
      other_currency = Currency[other_currency]
      return Money.new(1.0, self, on) if self == other_currency
      Money.new(call_exchange_handler(other_currency, on), other_currency, on)
    end

    def to_s
      id
    end

    protected

    def call_exchange_handler(other_currency, date)
      @@exchange_handler.call(id, other_currency.id, date)
    end
  end
end
