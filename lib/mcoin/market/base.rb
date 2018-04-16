# frozen_string_literal: true

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
        @retries = 0
      end

      def name
        self.class.name.split('::').last
      end

      def fetch
        @data ||= JSON.parse(Net::HTTP.get(uri))
        self
      rescue JSON::ParserError
        return nil if @retries >= 3
        @retries += 1
        retry
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
