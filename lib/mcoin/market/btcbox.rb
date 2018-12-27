# frozen_string_literal: true

module Mcoin
  module Market
    # :nodoc:
    class Btcbox < Base
      ENDPOINT = 'https://www.btcbox.co.jp/api/v1/ticker?coin=%<type>s'

      def watch(type, currency)
        @pairs.add({ type: type.to_s.downcase, currency: currency.to_s.downcase })
      end

      private

      def build_ticker(pair, response)
        Data::Ticker.new(
          :Btcbox, pair[:type].upcase, 'JPY',
          last: response['last'],
          ask:  response['sell'], bid:  response['buy'],
          low:  response['low'],  high: response['high'],
          volume:    response['vol'],
          timestamp: Time.now.utc.to_i
        )
      end
    end
  end
end
