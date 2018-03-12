# DocsplitProcessor

This gem provides a custom processor for use with the paperclip gem. The processor converts `doc` and `docx` documents to `pdf` using the docsplit gem.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'docsplit_processor'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install docsplit_processor

## Usage

TODO: Write usage instructions here

To use the processor, add it to the `styles` option where paperclip is being used. For example,

``` ruby
  has_attached_file :cv,
    path: PAPERCLIP_PATH,
    styles: { pdf: {  format: :pdf } },
    processors: [:docsplit_processor]
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/hiring-hub/docsplit_processor.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
