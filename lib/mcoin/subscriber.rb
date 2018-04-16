# frozen_string_literal: true

module Mcoin
  class Subscriber
    attr_reader :markets, :pairs

    def initialize(pairs = [], market = Market.available)
      @pairs = pairs_from(pairs)
      @markets = markets_from(market)
    end

    def start(interval = 1, &block)
      loop do
        Parallel.async(markets, :fetch) do |result|
          yield result.to_ticker
        end
        sleep interval
      end
    end

    protected

    def pairs_from(picked)
      @pairs ||= (picked || ['BTC-USD']).uniq.map do |pair|
        pair.split('-').map(&:to_sym)
      end
    end

    def markets_from(picked)
      @markets ||= picked.map do |name|
        pairs.map do |pair|
          Market
            .pick(name)
            .new(*pair)
        end
      end.flatten
    end
  end
end
