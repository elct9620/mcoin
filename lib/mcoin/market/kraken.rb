module Mcoin
  module Market
    # :nodoc:
    class Kraken < Base
      # rubocop:disable Metrics/LineLength
      ENDPOINT = 'https://api.kraken.com/0/public/Ticker?pair=%<type>s%<currency>s'.freeze

      def initialize(type, currency)
        type = swap_btc(type)
        super
      end

      def to_ticker
        fetch
        Data::Ticker.new(
          :Kraken,
          swap_btc(@type), @currency,
          last: @data['c'][0],
          ask: @data['a'][0], bid: @data['b'][0],
          low: @data['l'][1], high: @data['h'][1],
          volume: @data['v'][1]
        )
      end

      def fetch
        super
        return self if @data['result'].nil?
        @data = @data.dig('result', "X#{@type}Z#{@currency}")
        self
      end

      def swap_btc(type)
        return :BTC if type == :XBT
        return :XBT if type == :BTC
        type
      end
    end
  end
end
