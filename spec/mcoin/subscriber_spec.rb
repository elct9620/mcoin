# frozen_string_literal: true

RSpec.describe Mcoin::Subscriber do
  subject(:subscriber) { described_class.new(['BTC-USD'], [:Bitfinex]) }

  let(:market) { instance_double(Mcoin::Market::Bitfinex) }

  before do
    allow(Mcoin::Parallel).to receive(:async).and_yield(market)
    allow(market).to receive(:to_ticker).and_return([])

    # TODO: Avoid subject stubs
    # rubocop:disable RSpec/SubjectStub
    allow(subscriber).to receive(:loop).and_yield
    allow(subscriber).to receive(:sleep)
    # rubocop:enable RSpec/SubjectStub
  end

  describe '#start' do
    subject(:when_start) { subscriber.start }

    it { expect { when_start }.to change(subscriber, :running?).from(false).to(true) }
  end

  describe '#stop' do
    subject(:when_stop) { subscriber.stop }

    before { subscriber.start }

    it { expect { when_stop }.to change(subscriber, :running?).from(true).to(false) }
  end

  describe '#running?' do
    subject { subscriber.running? }

    it { is_expected.to be_falsy }

    context 'when start subscriber' do
      before { subscriber.start }

      it { is_expected.to be_truthy }
    end
  end

  describe '#stopped?' do
    subject { subscriber.stopped? }

    it { is_expected.to be_truthy }

    context 'when start subscriber' do
      before { subscriber.start }

      it { is_expected.to be_falsy }
    end
  end
end
