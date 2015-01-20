require 'money/currency'

describe Money::Currency do
  describe '.[]' do
    let(:usd) { Money::Currency.new('USD') }
    it 'creates a now currency object' do
      expect(Money::Currency['USD']).to eq usd
    end
    context 'when Currency is given' do
      it 'returns the given object' do
        expect(Money::Currency[usd]).to be usd
      end
    end
  end
  describe '#to' do
    let(:usd) { Money::Currency['USD'] }
    let(:exchange_handler) { Proc.new { |a, b, date| 5.0 } }
    before do
      Money::Currency.exchange(&exchange_handler)
    end
    it 'calls exchange handler' do
      expect(exchange_handler)
        .to receive(:call)
        .with 'USD', 'BRL', Date.parse('2011-01-01')
      usd.to 'BRL', on: Date.parse('2011-01-01')
    end

    it 'wraps exchange handler result in Money' do
      expect(usd.to 'BRL', on: Date.parse('2011-01-01'))
        .to eq Money.new(5.0, 'BRL', Date.parse('2011-01-01'))
    end

    context 'when converting to the same currency' do
      it 'returns 1.0 with the same currency' do
        expect(usd.to 'USD', on: Date.parse('2011-01-01'))
          .to eq Money.new(1.0, 'USD', Date.parse('2011-01-01'))
      end
    end
  end
end
