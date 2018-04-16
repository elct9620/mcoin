# frozen_string_literal: true

require 'mcoin/version'

# :nodoc:
module Mcoin
  TYPES = %i[BTC ETH].freeze
  CURRENCY = %i[USD].freeze

  autoload :Command, 'mcoin/command'
  autoload :Market, 'mcoin/market'
  autoload :Data, 'mcoin/data'
  autoload :Printer, 'mcoin/printer'
  autoload :Parallel, 'mcoin/parallel'
  autoload :InfluxDB, 'mcoin/influx_db'
  autoload :Subscriber, 'mcoin/subscriber'
end
