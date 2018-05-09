# frozen_string_literal: true

require 'time'

module Mcoin
  module Market
    # :nodoc:
    class Hitbtc < Base
      ENDPOINT = 'https://api.hitbtc.com/api/2/public/ticker/%<type>s%<currency>s'

      def to_ticker
        fetch
        Data::Ticker.new(
          :Hitbtc, @type, @currency,
          last: @data['last'],
          ask:  @data['ask'],  bid: @data['bid'],
          high: @data['high'], low: @data['low'],
          volume: @data['volume'],
          timestamp: Time.parse(@data['timestamp']).to_f
        )
      end
    end
  end
end
