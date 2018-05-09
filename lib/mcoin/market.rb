# frozen_string_literal: true

module Mcoin
  # :nodoc:
  module Market
    autoload :Base, 'mcoin/market/base'
    autoload :Bitfinex, 'mcoin/market/bitfinex'
    autoload :Bitstamp, 'mcoin/market/Bitstamp'
    autoload :Kraken, 'mcoin/market/kraken'
    autoload :Binance, 'mcoin/market/binance'
    autoload :Bitbank, 'mcoin/market/bitbank'
    autoload :Bitflyer, 'mcoin/market/bitflyer'
    autoload :Bittrex, 'mcoin/market/bittrex'
    autoload :Btcbox, 'mcoin/market/btcbox'
    autoload :Coincheck, 'mcoin/market/coincheck'
    autoload :Cryptopia, 'mcoin/market/cryptopia'
    autoload :Hitbtc, 'mcoin/market/hitbtc'
    autoload :Huobi, 'mcoin/market/huobi'
    autoload :Kucoin, 'mcoin/market/kucoin'
    autoload :Okex, 'mcoin/market/okex'
    autoload :Quoinex, 'mcoin/market/quoinex'
    autoload :Zaif, 'mcoin/market/zaif'

    def self.pick(name)
      const_get(name)
    end

    def self.available
      constants - [:Base]
    end
  end
end
