require 'pp'
require 'json'
require 'net/http'

module Mcoin
  module Market
    # :nodoc:
    class Base
      def initialize(type, currency)
        @type = type
        @currency = currency
      end

      def print
        fetch
        puts '=== Result ==='
        Printer.new(to_ticker).print
        self
      end

      def save(option)
        puts '=== InfluxDB ==='
        InfluxDB.new(
          option.endpoint,
          option.database,
          option.username,
          option.password
        ).save([to_ticker.to_influx(market: name)])
        puts 'Saved'
        self
      end

      def name
        self.class.name.split('::').last
      end

      def fetch
        @data ||= JSON.parse(Net::HTTP.get(uri))
        self
      end

      def to_ticker
        raise NotImplementedError
      end

      def uri
        options = { type: @type.upcase, currency: @currency.upcase }
        uri = format(self.class.const_get(:ENDPOINT), options)
        URI(uri)
      end
    end
  end
end
