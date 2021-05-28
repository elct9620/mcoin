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
        @retries = 0
        @http = Net::HTTP.new(uri.host, uri.port)
        @http.use_ssl = ssl?
      end

      def watch(type, currency)
        @pairs.add({ type: type.to_s.upcase, currency: currency.to_s.upcase })
      end

      def name
        self.class.name.split('::').last
      end

      # TODO: Send request in sequence to avoid Net::HTTPBadResponse
      def fetch # rubocop:disable Metrics/MethodLength
        @results = []
        @http.start unless @http.started?
        @pairs.each do |pair|
          uri = URI(format(self.class.const_get(:ENDPOINT), pair))
          request = Net::HTTP::Get.new(uri)
          @results << [pair, JSON.parse(@http.request(request)&.body)]
        end
        self
      rescue JSON::ParserError
        return self if @retries >= 3

        @retries += 1
        retry
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

      private

      def build_ticker(_pair, _response)
        raise NotImplementedError
      end
    end
  end
end
