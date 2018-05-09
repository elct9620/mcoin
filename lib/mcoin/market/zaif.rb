# frozen_string_literal: true

require 'time'

module Mcoin
  module Market
    # :nodoc:
    class Zaif < Base
      ENDPOINT = 'https://api.zaif.jp/api/1/ticker/%<type>s_%<currency>s'

      def initialize(type, currency)
        type = swap_cms(type)
        super
      end

      def to_ticker
        fetch
        Data::Ticker.new(
          :Zaif, swap_cms(@type), @currency,
          last: @data['last'],
          ask: @data['ask'], bid: @data['bid'],
          high: @data['high'], low: @data['low'],
          volume: @data['volume'],
          timestamp: Time.now.to_i
        )
      end

      def uri
        options = { type: @type.downcase, currency: @currency.downcase }
        uri = format(self.class.const_get(:ENDPOINT), options)
        URI(uri)
      end

      def swap_cms(type)
        return 'ERC20.CMS' if type == :CMS
        return :CMS if type == 'ERC20.CMS'
        type
      end
    end
  end
end
