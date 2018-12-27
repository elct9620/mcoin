# frozen_string_literal: true

module Mcoin
  class Subscriber
    attr_reader :markets, :pairs

    def initialize(pairs = nil, markets = Market.available)
      @pairs = pairs_from(pairs)
      @markets = markets_from(markets)
    end

    def start(interval = 1, &block)
      loop do
        Parallel.async(@markets, :fetch) do |result|
          result.to_ticker.each do |ticker|
            yield ticker
          end
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
      picked.map do |name|
        market = Market.pick(name).new
        pairs.map do |pair|
          market.watch(*pair)
        end
        market
      end.flatten
    end
  end
end
