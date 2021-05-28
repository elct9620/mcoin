# frozen_string_literal: true

RSpec.describe Mcoin::Data::Ticker do
  subject(:ticker) { described_class.new(:Bitfinex, :BTC, :USD, data) }

  let(:data) do
    {
      last: '2553.34440604',
      ask: '2553.0',
      bid: '2552.2',
      low: '2421.8',
      high: '2827.4',
      volume: '161246.2123488700002',
      timestamp: '1622214960.7180142'
    }
  end

  describe '#time' do
    subject { ticker.time }

    it { is_expected.to eq('2021-05-28 15:16:00 +0000') }

    context 'when offset is +08:00' do
      subject { ticker.time(offset: '+08:00') }

      it { is_expected.to eq('2021-05-28 23:16:00 +0800') }
    end
  end
end
