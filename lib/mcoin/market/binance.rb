# frozen_string_literal: true

require 'time'

module Mcoin
  module Market
    # :nodoc:
    class Binance < Base
      ENDPOINT = 'https://api.binance.com/api/v1/ticker/24hr?symbol=%<type>s%<currency>s'

      def to_ticker
        fetch
        Data::Ticker.new(
          :Binance, @type, @currency,
          last: @data['lastPrice'],
          ask:  @data['askPrice'], bid:  @data['bidPrice'],
          low:  @data['lowPrice'], high: @data['highPrice'],
          volume: @data['volume'],
          timestamp: Time.now.to_i
        )
      end
    end
  end
end
