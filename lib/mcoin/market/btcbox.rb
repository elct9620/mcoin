# frozen_string_literal: true

require 'time'

module Mcoin
  module Market
    # :nodoc:
    class Btcbox < Base
      ENDPOINT = 'https://www.btcbox.co.jp/api/v1/ticker?coin=%<type>s'

      def to_ticker
        fetch
        Data::Ticker.new(
          :Btcbox, @type, 'JPY',
          last: @data['last'],
          ask:  @data['sell'], bid:  @data['buy'],
          low:  @data['low'],  high: @data['high'],
          volume:    @data['vol'],
          timestamp: Time.now.utc.to_i
        )
      end

      def uri
        options = { type: @type.downcase }
        uri     = format(self.class.const_get(:ENDPOINT), options)
        URI(uri)
      end
    end
  end
end
