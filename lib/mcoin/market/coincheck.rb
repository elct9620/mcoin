# frozen_string_literal: true

require 'time'

module Mcoin
  module Market
    # :nodoc:
    class Coincheck < Base
      ENDPOINT = 'https://coincheck.com/api/ticker?pair=%<type>s_%<currency>s'

      def to_ticker
        fetch
        Data::Ticker.new(
          :Coincheck, @type, @currency,
          last: @data['last'],
          ask:  @data['ask'],  bid: @data['bid'],
          high: @data['high'], low: @data['low'],
          volume: @data['volume'],
          timestamp: @data['timestamp']
        )
      end

      def uri
        options = { type: @type.downcase, currency: @currency.downcase }
        uri = format(self.class.const_get(:ENDPOINT), options)
        URI(uri)
      end
    end
  end
end
