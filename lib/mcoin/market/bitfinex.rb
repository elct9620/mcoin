module Mcoin
  module Market
    # :nodoc:
    class Bitfinex < Base
      # rubocop:disable Metrics/LineLength
      ENDPOINT = 'https://api.bitfinex.com/v1/pubticker/%<type>s%<currency>s'.freeze

      def to_ticker
        fetch
        Data::Ticker.new(
          @type, @currency,
          last: @data['last_price'],
          ask: @data['ask'], bid: @data['bid'],
          low: @data['low'], high: @data['high'],
          volume: @data['volume']
        )
      end
    end
  end
end
