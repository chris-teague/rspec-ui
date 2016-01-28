# Rspec::Ui

Gem that integrates with Rspec & UXSpec.com to help you build a suite of UI & UX
features to test across multiple devices.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rspec-ui'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rspec-ui

## Usage


In your spec helper file:

```ruby
require "rspec/ui"

UxSpec.configure do |config|
  config.token = 'your_token_here'
end
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/rspec-ui/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
