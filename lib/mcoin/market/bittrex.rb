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
          last: response['Last'].to_s,
          ask:  response['Ask'].to_s,  bid:  response['Bid'].to_s,
          low:  response['Low'].to_s,  high: response['High'].to_s,
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
