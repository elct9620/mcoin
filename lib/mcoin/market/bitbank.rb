# frozen_string_literal: true

module Mcoin
  module Market
    # :nodoc:
    class Bitbank < Base
      ENDPOINT = 'https://public.bitbank.cc/%<type>s_%<currency>s/ticker'

      def watch(type, currency)
        type = swap_bch(type.to_s.downcase)
        @pairs.add({ type: type, currency: currency.to_s.downcase })
      end

      private

      def build_ticker(pair, response)
        response = response['data']
        Data::Ticker.new(
          :Bitbank, swap_bch(pair[:type]).upcase, pair[:currency].upcase,
          last: response['last'],
          ask:  response['sell'], bid:  response['buy'],
          low:  response['low'],  high: response['high'],
          volume: response['vol'],
          timestamp: response['timestamp'].to_f / 1000
        )
      end

      def swap_bch(type)
        return 'bcc' if type == 'bch'
        return 'bch' if type == 'bcc'
        type
      end
    end
  end
end
