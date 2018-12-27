# frozen_string_literal: true

module Mcoin
  module Market
    # :nodoc:
    class Coincheck < Base
      ENDPOINT = 'https://coincheck.com/api/ticker?pair=%<type>s_%<currency>s'

      def watch(type, currency)
        @pairs.add({ type: type.to_s.downcase, currency: currency.to_s.downcase })
      end

      private

      def build_ticker(pair, response)
        Data::Ticker.new(
          :Coincheck, pair[:type].upcase, pair[:currency],
          last: response['last'].to_s,
          ask:  response['ask'].to_s,  bid: response['bid'].to_s,
          high: response['high'].to_s, low: response['low'].to_s,
          volume: response['volume'],
          timestamp: response['timestamp']
        )
      end
    end
  end
end
