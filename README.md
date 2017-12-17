# Viisp::Auth

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'viisp-auth'
```

## Usage

#### Get ticket

```ruby
ticket = VIISP::Auth.ticket
```

#### Redirect user

Redirect user to authentication portal with ticket.

```html
<form id="login" action="<%= VIISP::Auth.portal_endpoint %>" method="post">
  <input type="hidden" name="ticket" value="<%= @ticket %>">
</form>
<script type='text/javascript'>
  document.getElementById('login').submit();
</script>
```

Sample form: https://jsfiddle.net/kmrzpqwk/1/

#### Get identity

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
