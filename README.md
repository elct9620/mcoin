# Mcoin

This is a side-project for me to monitor BTC/ETH. The target is to create a helpful command line tool that can run as a cronjob to import data to InfluxDB and do some analytics.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mcoin'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mcoin

## Usage

### Ticker

Add `-m` to specify market name

```
mcoin ticker -m Bitfinex
mcoin ticker -m Bitfinex -m Kraken # Multiple
```

If you want to save it into InfluxDB, add database information.

```
mcoin ticker -m Bitfinex -d monitor -e http://localhost:8086
```

To get more information please use `-h` option.

### Subscriber

If you want to subscribe market in your project, you can use `Subscriber`

```ruby
require 'mcoin'

# Leave blank to subscribe all available market
subscriber = Mcoin::Subscriber.new(['ETH-USD', 'BTC-USD'], [:Bitinfex])
subscriber.start do |ticker|
  # Deal with Mcoin::Data::Ticker object
end
```

Please note, the ticker pulls data asynchronously from the market, so the timestamp may not be totally same when you receive it.

## Roadmap

* [x] Fetch ticker
  * [x] Fetch in parallels
  * [x] Fetch from multiple market
  * [x] Fetch multiple coin type via specify `pair`
* [ ] Support more public API command
* [ ] Improve printer
* [ ] Generalize database save interface

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake ` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/elct9620/mcoin.
