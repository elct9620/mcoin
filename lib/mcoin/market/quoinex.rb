# frozen_string_literal: true

require 'time'

module Mcoin
  module Market
    # :nodoc:
    class Quoinex < Base
      ENDPOINT = 'https://api.quoine.com/products/%<type>s'

      CONFIG = YAML.load_file('config.yml')['quoinex']

      def to_ticker
        fetch
        Data::Ticker.new(
          :Quoinex, @type, @currency,
          last: @data['last_price_24h'],
          ask:  @data['market_ask'], bid:  @data['market_bid'],
          low:  @data['low_market_bid'], high: @data['high_market_ask'],
          volume:    @data['volume_24h'],
          timestamp: Time.now.utc.to_i
        )
      end

      def uri
        options = { type: to_id }
        uri     = format(self.class.const_get(:ENDPOINT), options)
        URI(uri)
      end

      private

      def to_id
        code = "#{ @type }-#{ @currency }"
        CONFIG[code]['alias'] if CONFIG[code]
      end
    end
  end
end
