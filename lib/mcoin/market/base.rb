# frozen_string_literal: true

require 'pp'
require 'set'
require 'json'
require 'bigdecimal'
require 'net/http'

module Mcoin
  module Market
    # The market to subscribe
    #
    # @since 0.1.0
    class Base
      # @since 0.7.0
      ENDPOINT = 'https://api.bitfinex.com/v1/pubticker/%<type>s%<currency>s'

      # @since 0.1.0
      attr_reader :results, :pairs

      # @since 0.1.0
      def initialize
        @pairs = Set.new
        @results = []
        @http = Net::HTTP.new(uri.host, uri.port)
        @http.use_ssl = ssl?
      end

      # @param [String] crypto type
      # @param [String] currency
      #
      # @since 0.1.0
      def watch(type, currency)
        @pairs.add({ type: type.to_s.upcase, currency: currency.to_s.upcase })
      end

      # @return [String] market name
      #
      # @since 0.1.0
      def name
        self.class.name.split('::').last
      end

      # Pull market ticker data
      #
      # @since 0.1.0
      def fetch
        @results = []
        @http.start unless @http.started?
        @pairs.each do |pair|
          uri = URI(format(self.class.const_get(:ENDPOINT), pair))
          request = Net::HTTP::Get.new(uri)

          with_retry Net::HTTPBadResponse, JSON::ParserError do
            @results << [pair, JSON.parse(@http.request(request)&.body)]
          end
        end
        self
      end

      # Convert result to ticker
      #
      # @deprecated ticker will refactor as default return result
      #
      # @since 0.1.0
      def to_ticker
        @results.map do |pair, response|
          build_ticker(pair, response)
        end
      end

      # @return [URI] the base uri
      #
      # @since 0.7.0
      def uri
        @uri ||= URI(format(self.class.const_get(:ENDPOINT), type: '', currency: ''))
      end

      # @return [TruClass|FalseClass] use ssl to connect to market
      #
      # @since 0.7.0
      def ssl?
        uri.scheme == 'https'
      end

      private

      # @since 0.7.0
      def with_retry(*exceptions, retries: 3)
        count = 0
        begin
          yield
        rescue *exceptions
          count += 1
          count >= retries ? self : retry
        end
      end

      # @since 0.1.0
      def build_ticker(_pair, _response)
        raise NotImplementedError
      end
    end
  end
end
