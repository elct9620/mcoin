module Mcoin
  module Data
    # :nodoc:
    class Ticker
      attr_reader :type, :currency
      attr_accessor :last, :ask, :bid, :low, :high, :volume

      def initialize(type, currency, data = {})
        @type = type
        @currency = currency
        data.each do |key, value|
          send("#{key}=", value)
        end
      end

      def to_influx(tags = {}, values = {})
        tags = { type: @type, currency: @currency }.merge(tags)
        values = {
          last: @last,
          ask: @ask, bid: @bid,
          low: @low, high: @high,
          volume: @volume
        }.merge(values)
        "prices,#{tags.map { |t| t.join('=') }.join(',')} " \
        "#{values.map { |v| v.join('=') }.join(',')}"
      end
    end
  end
end
