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
          last: @data['last'].to_s,
          ask:  @data['ask'].to_s,  bid: @data['bid'].to_s,
          high: @data['high'].to_s, low: @data['low'].to_s,
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
