# VIISP::Auth

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'viisp-auth'
```

## Usage

Get an authentication ticket:

```ruby
ticket = VIISP::Auth.ticket
```

Redirected user to authentication portal with ticket using http POST.
`VIISP::Auth.portal_endpoint` is a convenience method to get portal URL.

Redirect form for testing: https://jsfiddle.net/kmrzpqwk/

After successful authentication identity data can be fetched once.

```ruby
identity_data = VIISP::Auth.ticket(ticket: ticket)
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/laurynas/viisp-auth. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the VIISP::Auth project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/laurynas/viisp-auth/blob/master/CODE_OF_CONDUCT.md).
