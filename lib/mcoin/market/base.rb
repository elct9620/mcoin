# frozen_string_literal: true

require 'pp'
require 'set'
require 'json'
require 'bigdecimal'
require 'net/http'

module Mcoin
  module Market
    # :nodoc:
    class Base
      attr_reader :results

      def initialize
        @pairs = Set.new
        @results = []
        @http = Net::HTTP.new(uri.host, uri.port)
        @http.use_ssl = ssl?
      end

      def watch(type, currency)
        @pairs.add({ type: type.to_s.upcase, currency: currency.to_s.upcase })
      end

      def name
        self.class.name.split('::').last
      end

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

      def to_ticker
        @results.map do |pair, response|
          build_ticker(pair, response)
        end
      end

      def uri
        @uri ||= URI(format(self.class.const_get(:ENDPOINT), type: '', currency: ''))
      end

      def ssl?
        uri.scheme == 'https'
      end

      def with_retry(*exceptions, retries: 3)
        count = 0
        begin
          yield
        rescue *exceptions
          count += 1
          count >= retries ? raise : retry
        end
      end

      private

      def build_ticker(_pair, _response)
        raise NotImplementedError
      end
    end
  end
end
