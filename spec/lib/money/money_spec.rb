require 'money/money'

describe Money do
  describe '#exchange_to' do
    before do
      Money::Currency.exchange do |a, b, date|
        1.5
      end
    end
    it 'finds the rate and multiplies by the amount' do
      expect(Money.new(1_000.0, 'BRL').exchange_to 'USD').to eq Money.new(1_500.0, 'USD')
    end
  end
  describe '#-' do
    it 'substracts the given value from amount and returns a new object' do
      expect(Money.new(1_000.0, 'BRL') - 100.0).to eq Money.new(900.0, 'BRL')
    end
    context 'when the given value is a Money' do
      it 'substracts the given money amount from amount and returns a new Money' do
        expect(Money.new(1_000.0, 'BRL') - Money.new(100.0, 'BRL')).to eq Money.new(900.0, 'BRL')
      end
    end
    context 'when the given value is not recognized' do
      it 'raises an error' do
        expect { Money.new(1_000.0, 'BRL') - 'TEST' }.to raise_error(TypeError)
      end
    end
    context 'when the given money is in other currency' do
      it 'converts the given amount before the operation' do
        expect(Money.new(1_150.0, 'BRL') - Money.new(100.0, 'USD')).to eq Money.new(1_000.0, 'BRL')
      end
    end
    context 'when the given money is on different date' do
      it 'raises an error' do
        expect { Money.new(1_000.0, 'BRL', Date.parse('2015-06-24')) - Money.new(100.0, 'BRL', Date.parse('2015-06-25')) }.
          to raise_error("Can't calculate the amount with different dates.")
      end
    end 
    context 'when the given money is on nil date' do
      it 'substracts the given money amount from amount and returns a new Money' do
        expect(Money.new(1_000.0, 'BRL', Date.parse('2015-06-24')) - Money.new(100.0, 'BRL')).
        to eq Money.new(900.0, 'BRL', Date.parse('2015-06-24'))
      end
    end 
    context 'when the date is nil and the given money has a date' do
      it 'substracts the given money amount from amount and returns a new Money with the given money date' do
        expect(Money.new(1_000.0, 'BRL') - Money.new(100.0, 'BRL', Date.parse('2015-06-24'))).
        to eq Money.new(900.0, 'BRL', Date.parse('2015-06-24'))
      end
    end      
  end
  describe '#/' do
    it 'divides the amount by the given value and returns a new object' do
      expect(Money.new(1_000.0, 'BRL') / 100.0).to eq Money.new(10.0, 'BRL')
    end
    context 'when the given value is a Money' do
      it 'divides the amount by the given money amount and returns a new Money' do
        expect(Money.new(1_000.0, 'BRL') / Money.new(100.0, 'BRL')).to eq Money.new(10.0, 'BRL')
      end
    end
    context 'when the given value is not recognized' do
      it 'raises an error' do
        expect { Money.new(1_000.0, 'BRL') / 'TEST' }.to raise_error(TypeError)
      end
    end
    context 'when the given money is in other currency' do
      it 'converts the given amount before the operation' do
        expect(Money.new(1_500.0, 'BRL') / Money.new(100.0, 'USD')).to eq Money.new(10.0, 'BRL')
      end
    end 
    context 'when the given money is on nil date' do
      it 'divides the amount by the given money amount and returns a new Money' do
        expect(Money.new(1_000.0, 'BRL', Date.parse('2015-06-24')) / Money.new(10.0, 'BRL')).
        to eq Money.new(100.0, 'BRL', Date.parse('2015-06-24'))
      end
    end 
    context 'when the date is nil and the given money has a date' do
      it 'divides the amount by the given money amount and returns a new Money with the given money date' do
        expect(Money.new(1_000.0, 'BRL') / Money.new(10.0, 'BRL', Date.parse('2015-06-24'))).
        to eq Money.new(100.0, 'BRL', Date.parse('2015-06-24'))
      end 
    end      
  end
  describe '#*' do
    it 'multiplies the amount by the given value and returns a new object' do
      expect(Money.new(1_000.0, 'BRL') * 100.0).to eq Money.new(100_000.0, 'BRL')
    end
    context 'when the given value is a Money' do
      it 'multiplies the amount by the given money amount and returns a new Money' do
        expect(Money.new(1_000.0, 'BRL') * Money.new(100.0, 'BRL')).to eq Money.new(100_000.0, 'BRL')
      end
    end
    context 'when the given value is not recognized' do
      it 'raises an error' do
        expect { Money.new(1_000.0, 'BRL') * 'TEST' }.to raise_error(TypeError)
      end
    end
    context 'when the given money is in other currency' do
      it 'converts the given amount before the operation' do
        expect(Money.new(1_000.0, 'BRL') * Money.new(1.0, 'USD')).to eq Money.new(1_500.0, 'BRL')
      end
    end 
    context 'when the given money is on nil date' do
      it 'multiplies the amount by the given money amount and returns a new Money' do
        expect(Money.new(100.0, 'BRL', Date.parse('2015-06-24')) * Money.new(10.0, 'BRL')).
        to eq Money.new(1_000.0, 'BRL', Date.parse('2015-06-24'))
      end
    end 
    context 'when the date is nil and the given money has a date' do
      it 'multiplies the amount by the given money amount and returns a new Money with the given money date' do
        expect(Money.new(100.0, 'BRL') * Money.new(10.0, 'BRL', Date.parse('2015-06-24'))).
        to eq Money.new(1_000.0, 'BRL', Date.parse('2015-06-24'))
      end 
    end         
  end
  describe '#+' do
    it 'adds the amount to the given value and returns a new object' do
      expect(Money.new(1_000.0, 'BRL') + 100.0).to eq Money.new(1_100.0, 'BRL')
    end
    context 'when the given value is a Money' do
      it 'adds the amount to the given money amount and returns a new Money' do
        expect(Money.new(1_000.0, 'BRL') + Money.new(100.0, 'BRL')).to eq Money.new(1_100.0, 'BRL')
      end
    end
    context 'when the given value is not recognized' do
      it 'raises an error' do
        expect { Money.new(1_000.0, 'BRL') + 'TEST' }.to raise_error(TypeError)
      end
    end
    context 'when the given money is in other currency' do
      it 'converts the given amount before the operation' do
        expect(Money.new(1_000.0, 'BRL') + Money.new(100.0, 'USD')).to eq Money.new(1_150.0, 'BRL')
      end
    end 
    context 'when the given money is on nil date' do
      it 'adds the amount to the given money amount and returns a new Money' do
        expect(Money.new(1_000.0, 'BRL', Date.parse('2015-06-24')) + Money.new(100.0, 'BRL')).
        to eq Money.new(1_100.0, 'BRL', Date.parse('2015-06-24'))
      end
    end 
    context 'when the date is nil and the given money has a date' do
      it 'adds the amount to the given money amount and returns a new Money with the given money date' do
        expect(Money.new(1_000.0, 'BRL') + Money.new(100.0, 'BRL', Date.parse('2015-06-24'))).
        to eq Money.new(1_100.0, 'BRL', Date.parse('2015-06-24'))
      end 
    end         
  end
  describe '#coerce' do
    it 'wraps first operator in a Money' do
      expect(1_500.0 - Money.new(1_000.0, 'BRL')).to eq Money.new(500.0, 'BRL')
    end
  end
  describe '#to_s' do
    it 'is "(amount) (currency)"' do
      expect(Money.new(100.0, 'BRL').to_s).to eq '100.0 BRL'
    end
    context 'when date is defined' do
      it 'is "(amount) (currency) on (date)"' do
        expect(Money.new(100.0, 'BRL', Date.parse('2011-01-01')).to_s).to eq '100.0 BRL on 2011-01-01'
      end
    end
  end
  describe '#inspect' do
    it 'is "<#Money (to_s)>"' do
      expect(Money.new(100.0, 'BRL').inspect).to eq '<#Money 100.0 BRL>'
    end
  end
end
