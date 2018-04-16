# frozen_string_literal: true

module Mcoin
  class Subscriber
    attr_reader :markets

    def initialize(picked = Market.available, type = :BTC, currency = :USD)
      @markets = markets_from(picked, type, currency)
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

    def markets_from(picked, type, currency)
      @markets ||= picked.map do |name|
        Market
          .pick(name)
          .new(type, currency)
      end
    end
  end
end
