# Squash::Rack

Integrates [squash](https://github.com/SquareSquash/web) logging into your
rack apps.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'squash-rack'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install squash-rack

## Usage

### Sinatra

```ruby
require 'squash/rack'

Squash::Ruby.configure :api_key => 'my_app_api_key',
  :api_host => 'https://my_squash_host',
  :environment => ENV["RACK_ENV"]

class MyApp < Sinatra::Application
  use Squash::Rack
end
```


### Padrino

Add the following to your padrino app's config/boot.rb:
```ruby
require 'squash/rack'
Squash::Ruby.configure :api_key => 'my_app_api_key',
  :api_host => 'https://my_squash_host',
  :environment => Padrino.env
Padrino::Application.use Squash::Rack
```

## Contributing

1. Fork it ( https://github.com/DylanGriffith/squash-rack/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
