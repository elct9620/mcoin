# frozen_string_literal: true

module Mcoin
  module Command
    # :nodoc:
    class Ticker < Base
      include HasMarket
      include HasPair
      include Saveable

      attr_reader :option

      description 'Show market information'

      def execute
        raise OptionParser::MissingArgument, :market if option.market.nil?
        print
        save if save?
      end

      def print
        tickers = Parallel.map(markets, :fetch).compact.map(&:to_ticker).flatten
        Printer.new(tickers).print
      end

      def save
        database.save(markets.map(&:to_ticker).map(&:to_influx))
      end

      def markets
        @markets ||= option.market.map do |name|
          market = Market.pick(name).new
          pairs.map do |pair|
            market.watch(*pair)
          end
          market
        end.flatten
      end

      def pairs
        @pairs ||= (option.pair || ['BTC-USD']).uniq.map do |pair|
          pair.split('-').map(&:to_sym)
        end
      end

      private

      def prepare
        super
        option.pair ||= []
      end
    end
  end
end
