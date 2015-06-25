require 'money/base'
require 'money/currency'

class Money
  def initialize(amount, currency, date=nil)
    super amount, Currency[currency], date
  end

  def exchange_to(other_currency, on: date)
    currency.to(Currency[other_currency], on: on) * amount
  end

  def +(other)
    calculate(:+, other)
  end

  def -(other)
    calculate(:-, other)
  end

  def /(other)
    calculate(:/, other)
  end

  def *(other)
    calculate(:*, other)
  end


  def coerce(other)
    [Money.new(other, currency, date), amount]
  end

  def to_s
    if date.nil?
      "#{amount} #{currency}"
    else
      "#{amount} #{currency} on #{date}"
    end
  end

  def inspect
    "<#Money #{to_s}>"
  end

  protected

  def calculate(operation, other)
    if other.kind_of?(Money)
      if other.date != date and other.date != nil and date != nil
        raise "Can't calculate the amount with different dates."
      end 
      new_date = date || other.date
      other = other.exchange_to(currency).amount
    else
      new_date = date
    end
    if other.kind_of?(Numeric)
      Money.new(amount.send(operation, other), currency, new_date)
    else
      raise TypeError, "#{other.class} can't be coerced into Money"
    end
  end
end
