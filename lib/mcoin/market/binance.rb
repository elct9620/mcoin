# frozen_string_literal: true

module Mcoin
  module Market
    # :nodoc:
    class Binance < Base
      ENDPOINT = 'https://api.binance.com/api/v1/ticker/24hr?symbol=%<type>s%<currency>s'

      private

      def build_ticker(pair, response)
        Data::Ticker.new(
          :Binance, pair[:type], pair[:currency],
          last: response['lastPrice'],
          ask: response['askPrice'], bid:  response['bidPrice'],
          low: response['lowPrice'], high: response['highPrice'],
          volume: response['volume'],
          timestamp: Time.now.to_i
        )
      end
    end
  end
end
