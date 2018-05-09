# frozen_string_literal: true

require 'time'

module Mcoin
  module Market
    # :nodoc:
    class Bittrex < Base
      ENDPOINT = 'https://bittrex.com/api/v1.1/public/getmarketsummary?market=%<currency>s-%<type>s'

      def initialize(type, currency)
        type = swap_bch(type)
        super
      end

      def to_ticker
        fetch
        response = @data['result'][0]
        Data::Ticker.new(
          :Bittrex, swap_bch(@type), @currency,
          last: response['Last'],
          ask:  response['Ask'],  bid:  response['Bid'],
          low:  response['Low'],  high: response['High'],
          volume:    response['Volume'],
          timestamp: Time.parse(response['TimeStamp']).to_f
        )
      end

      def swap_bch(type)
        return :BCC if type == :BCH
        return :BCH if type == :BCC
        type
      end
    end
  end
end
