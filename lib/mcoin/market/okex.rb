# frozen_string_literal: true

module Mcoin
  module Market
    # :nodoc:
    class Okex < Base
      ENDPOINT = 'https://www.okex.com/api/v1/ticker.do?symbol=%<type>s_%<currency>s'

      def watch(type, currency)
        @pairs.add({ type: type.to_s.downcase, currency: currency.to_s.downcase })
      end

      private

      def build_ticker(pair, response)
        response = response['ticker']
        Data::Ticker.new(
          :Okex, pair[:type].upcase, pair[:currency].upcase,
          last: response['last'],
          ask: response['sell'], bid:  response['buy'],
          low: response['low'],  high: response['high'],
          volume: response['vol'],
          timestamp: response['date'].to_i
        )
      end
    end
  end
end
