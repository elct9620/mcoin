# frozen_string_literal: true

RSpec.describe Mcoin::Parallel do
  let(:market) { instance_spy('Mcoin::Market::Base') }

  describe '.map' do
    subject(:when_parallel_map) { described_class.map([market], :fetch) }

    it 'is expected to async fetch market and return at same time' do
      when_parallel_map

      expect(market).to have_received(:fetch)
    end
  end

  describe '.async' do
    subject(:when_parallel_in_async) { described_class.async([market], :fetch, &->(ret) {}) }

    before do
      allow(Thread).to receive(:new).and_yield
    end

    it 'is expected to async fetch market' do
      when_parallel_in_async

      expect(market).to have_received(:fetch)
    end
  end
end
