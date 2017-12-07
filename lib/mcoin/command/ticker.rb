# frozen_string_literal: true

module Mcoin
  module Command
    # :nodoc:
    class Ticker < Base
      include HasMarket
      include HasType
      include Saveable

      attr_reader :option

      description 'Show market information'

      def execute
        raise OptionParser::MissingArgument, :market if option.market.nil?
        print
        save if save?
      end

      def print
        tickers = Parallel.map(markets, :fetch).map(&:to_ticker)
        Printer.new(tickers).print
      end

      def save
        database.save(markets.map(&:to_ticker).map(&:to_influx))
      end

      def markets
        @markets ||= option.market.map do |name|
          Market
            .pick(name)
            .new(option.type, option.currency)
        end
      end

      private

      def prepare
        super
        option.type = :BTC
        option.currency = :USD
      end
    end
  end
end
