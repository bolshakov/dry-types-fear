# Dry::Types::Fear

`Dry::Types` integration with [fear] allows using `Fear::Option` as optional type for `Dry::Types`

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add dry-types-fear

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install dry-types-fear

## Usage

Load the `:fear_option` extension in your application.

```ruby
require 'dry-types'
require 'dry/types/fear'

Dry::Types.load_extensions(:fear_option)

module Types
  include Dry.Types()
end
```

Append `.option` to a Type to return a `Fear::Option` object:

```ruby
Types::Option::Strict::Integer[nil] 
#=> Fear.none
Types::Option::Coercible::String[nil] 
#=> Fear.none
Types::Option::Strict::Integer[123] 
#=> Fear.some(123)
Types::Option::Strict::String[123]
#=> Fear.some(123)
Types::Option::Coercible::Float['12.3'] 
#=> Fear.some(12.3)
```

'Option' types can also accessed by calling `.option` on a regular type:

```ruby
Types::Strict::Integer.option # equivalent to Types::Option::Strict::Integer
```


You can define your own optional types:

```ruby
option_string = Types::Strict::String.option
option_string[nil]
# => Fear.none
option_string[nil].map(&:upcase)
# => Fear.none
option_string['something']
# => Fear.some('something')
option_string['something'].map(&:upcase)
# => Fear.some('SOMETHING')
option_string['something'].map(&:upcase).get_or_else { 'NOTHING' }
# => "SOMETHING"
```

You can use it with dry-struct as well:

```ruby
class User < Dry::Struct
  attribute :name, Types::Coercible::String
  attribute :age,  Types::Coercible::Integer.option
end

user = User.new(name: 'Bob', age: nil)
user.name #=> "Bob"
user.age #=> Fear.none 

user = User.new(name: 'Bob', age: 42)
user.age #=> Fear.some(42) 
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run 
`rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will 
allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, 
update the version number in the gemspec, and then run `bundle exec rake release`, which will create a git 
tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/bolshakov/dry-types-fear.

[fear]: https://github.com/bolshakov/fear
