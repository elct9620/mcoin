# Mcoin

This is a side-project for me to monitor BTC/ETH. The target is create a helpful command line tool can run as cronjob to import data to InfluxDB and make some analytics.

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

To fetch ticker information, add with `-m` to specify market.

```
mcoin -m Bitfinex
```

If you want to save it into InfluxDB, add database information.

```
mcoin -m Bitfinex -d monitor -e http://localhsot:8086
```

To get more information please use `-h` option.

## Roadmap

* [x] Fetch ticker
  * [ ] Fetch in parallels
  * [x] Fetch from multiple market
  * [ ] Fetch multiple coin type via specify `pair`
* [ ] Support more public API command
* [ ] Improve printer
* [ ] Generalize database save interface

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake ` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/elct9620/mcoin.
