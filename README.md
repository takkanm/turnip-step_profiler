# Turnip::StepProfiler

Tunip::StepProfiler is profiler for trunip steps.
This shows slowest steps.

```
Top 10 slow steps:
  it should die
    2.002311 seconds average (2.002 seconds / 1 call)
  I wait 1 seconds
    1.001842 seconds average (2.004 seconds / 2 call)
  there is a monster
    0.000384 seconds average (0.000 seconds / 1 call)
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'turnip-step_profiler'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install turnip-step_profiler

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/takkanm/turnip-step_profiler. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
