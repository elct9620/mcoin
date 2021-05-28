# frozen_string_literal: true

RSpec.describe Mcoin::Market::Base do
  subject(:market) { described_class.new }

  let(:http) { instance_spy(Net::HTTP) }
  let(:response) { instance_double(Net::HTTPSuccess, body: '{}') }

  before do
    allow(Net::HTTP).to receive(:new).and_return(http)
    allow(http).to receive(:request).and_return(response)
  end

  describe '#watch' do
    subject(:when_watch) { market.watch('BTC', 'USD') }

    it 'is expected to add BTC-USD to pairs' do
      when_watch
      expect(market.pairs).to include({ type: 'BTC', currency: 'USD' })
    end
  end

  describe '#name' do
    subject(:name) { market.name }

    it { is_expected.to eq('Base') }
  end

  describe '#uri' do
    subject(:uri) { market.uri }

    it { is_expected.to be_a(URI) }
  end

  describe '#ssl?' do
    subject(:is_ssl) { market.ssl? }

    it { is_expected.to be_truthy }
  end

  describe '#fetch' do
    subject(:when_fetch) { market.fetch }

    before { market.watch('BTC', 'USD') }

    it { expect { when_fetch }.to change { market.results.size }.by(1) }

    context 'when raise error' do
      before do
        allow(http).to receive(:request).and_raise(Net::HTTPBadResponse)
      end

      it { expect { when_fetch }.to change { market.results.size }.by(0) }
    end
  end

  describe '#to_ticker' do
    subject(:when_conver_to_ticker) { market.to_ticker }

    before do
      market.watch('BTC', 'USD')
      market.fetch
    end

    it 'is expected to call #build_ticker' do
      allow(market).to receive(:build_ticker)

      when_conver_to_ticker

      expect(market).to have_received(:build_ticker)
    end
  end
end
