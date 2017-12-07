require 'mcoin/version'

# :nodoc:
module Mcoin
  TYPES = %i[BTC ETH].freeze
  CURRENCY = %i[USD].freeze

  autoload :Command, 'mcoin/command'
  autoload :Market, 'mcoin/market'
  autoload :Data, 'mcoin/data'
  autoload :Printer, 'mcoin/printer'
end
