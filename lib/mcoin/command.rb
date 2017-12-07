require 'optparse'
require 'optparse/uri'
require 'ostruct'

module Mcoin
  # The command line interface
  class Command < OptionParser
    class << self
      def execute
        new
      end
    end

    attr_reader :option

    def initialize(&block)
      super
      prepare_options

      self.banner = '=== Mcoin : Bitcoin Monitor Tools ==='
      options_for_coin
      options_for_influxdb
      common_options

      parse!
      execute
    end

    def execute
      raise OptionParser::MissingArgument, :market if option.market.nil?
      Printer.new(markets.map(&:fetch).map(&:to_ticker)).print
      # TODO: Provide general interface
      markets.map { |m| m.save(option) } if influxdb?
    end

    def markets
      @markets ||= option.market.map do |name|
        Market
          .pick(name)
          .new(option.type, option.currency)
      end
    end

    def influxdb?
      option.endpoint && option.database
    end

    def on(name, *args)
      if args.first == :multiple
        args.shift
        option[name] = [] unless option[name].is_a?(Array)
        super(*args, ->(value) { option[name].push(value) })
      else
        super(*args, ->(value) { option[name] = value })
      end
    end

    def separator(content = nil)
      super ''
      super content unless content.nil?
    end

    private

    def prepare_options
      @option = OpenStruct.new
      @option.type = :BTC
      @option.currency = :USD
    end

    def common_options
      separator 'Common Options: '
      on_tail('-h', '--help', 'Show this message') do
        puts self
        exit
      end

      on_tail('-v', '--version', 'Show version') do
        puts "Mcoin #{VERSION}"
        exit
      end
    end

    def options_for_influxdb
      separator 'InfluxDB:'
      on(:endpoint, '-e', '--endpoint ENDPOINT', URI, 'Database Endpoint')
      on(:database, '-d', '--database NAME', String, 'Database Name')
      on(:username, '-u', '--username USERNAME', String, 'Database Username')
      on(:password, '-p', '--password PASSWORD', String, 'Database Password')
    end

    def options_for_coin
      on(:type, '-t', '--type TYPE',
         Mcoin::TYPES, "Available: #{Mcoin::TYPES.join(', ')}")
      on(:currency, '-c', '--currency CURRENCY',
         Mcoin::CURRENCY, "Available: #{Mcoin::CURRENCY.join(', ')}")
      on(:market, :multiple, '-m', '--market MARKET',
         Mcoin::Market.available,
         "Available: #{Mcoin::Market.available.join(', ')}")
    end
  end
end
