# frozen_string_literal: true

module Mcoin
  module Market
    # :nodoc:
    class Bitbank < Base
      ENDPOINT = 'https://public.bitbank.cc/%<type>s_%<currency>s/ticker'

      def initialize(type, currency)
        type = swap_bch(type)
        super
      end

      def to_ticker
        fetch
        response = @data['data']
        Data::Ticker.new(
          :Bitbank, swap_bch(@type), @currency,
          last: response['last'],
          ask:  response['sell'], bid:  response['buy'],
          low:  response['low'],  high: response['high'],
          volume: response['vol'],
          timestamp: response['timestamp'].to_f / 1000
        )
      end

      def swap_bch(type)
        return :BCC if type == :BCH
        return :BCH if type == :BCC
        type
      end

      def uri
        options = { type: @type.downcase, currency: @currency.downcase }
        uri = format(self.class.const_get(:ENDPOINT), options)
        URI(uri)
      end
    end
  end
end
