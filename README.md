# Viisp::Auth

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'viisp-auth'
```

## Usage

To start authentication first you must get a ticket.

```ruby
ticket = VIISP::Auth.ticket
```

User should be redirected to authentication portal with ticket using http POST
Example: https://jsfiddle.net/kmrzpqwk/1/

`VIISP::Auth.portal_endpoint` is a convenience method to get portal URL.

After successful authentication identity data can be fetched once.

```ruby
identity_data = VIISP::Auth.ticket(ticket: ticket)
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/laurynas/viisp-auth. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Viisp::Auth project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/viisp-auth/blob/master/CODE_OF_CONDUCT.md).
