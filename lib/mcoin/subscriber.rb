# frozen_string_literal: true

module Mcoin
  # Subscribe Market to pull data
  #
  # @since 0.1.0
  class Subscriber
    # @since 0.1.0
    attr_reader :markets, :pairs

    # @param [Array|NilClass] pairs
    # @param [Array] markets
    #
    # @since 0.1.0
    def initialize(pairs = nil, markets = Market.available)
      @pairs = pairs_from(pairs)
      @markets = markets_from(markets)
      @running = true
    end

    # Start subscribe
    #
    # @param [Number] pull interval
    #
    # @since 0.1.0
    def start(interval = 1, &block)
      @running = true

      while running?
        Parallel.async(@markets, :fetch) do |result|
          result.to_ticker.each(&block)
        end

        sleep interval
      end
    end

    # Stop subscribe
    #
    # @since 0.1.0
    def stop
      @running = false
    end

    # Does subscriber running
    #
    # @since 0.1.0
    def running?
      @running == true
    end

    # Does subscriber stopped
    #
    # @since 0.1.0
    def stopped?
      @running == false
    end

    protected

    def pairs_from(picked)
      (picked || ['BTC-USD']).uniq.map do |pair|
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
