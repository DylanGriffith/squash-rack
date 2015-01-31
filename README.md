# Squash::Padrino

Integrates [squash](https://github.com/SquareSquash/web) logging into your
padrino apps.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'squash_padrino'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install squash_padrino

## Usage

Add the following to your padrino app's config/boot.rb:
```ruby
require 'squash/padrino/rack'
Squash::Ruby.configure :api_key => 'my_app_api_key',
  :api_host => 'https://my_squash_host',
  :environment => Padrino.env
Padrino::Application.use Squash::Padrino::Rack
```

## Contributing

1. Fork it ( https://github.com/DylanGriffith/squash-padrino/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
