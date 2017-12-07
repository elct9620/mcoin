module Mcoin
  # :nodoc:
  module Market
    autoload :Base, 'mcoin/market/base'
    autoload :Bitfinex, 'mcoin/market/bitfinex'
    autoload :Bitstamp, 'mcoin/market/Bitstamp'
    autoload :Kraken, 'mcoin/market/kraken'

    def self.pick(name)
      const_get(name)
    end

    def self.available
      constants - [:Base]
    end
  end
end
