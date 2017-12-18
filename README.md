# VIISP::Auth

[![Build Status](https://travis-ci.org/laurynas/viisp-auth.svg?branch=master)](https://travis-ci.org/laurynas/viisp-auth)

VIISP identity service documentation: https://www.epaslaugos.lt/portal/content/1257

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'viisp-auth'
```

## Configuration

```ruby
VIISP::Auth.configure do |c|
  c.pid = '1234'
  c.private_key = OpenSSL::PKey::RSA.new(File.read('your-private-key.pem'))
  c.postback_url = 'https://localhost'

  # optional
  c.providers = %w[auth.lt.identity.card auth.lt.bank]
  c.attributes = %w[lt-personal-code lt-company-code] 
  c.user_information = %w[firstName lastName companyName email]

  # enable test mode
  # (in test mode there is no need to set pid and private_key)
  c.test = true
end
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
identity = VIISP::Auth.identity(
  ticket: ticket,
  include_source_data: true,
)
```

Identity example:

```ruby
{
  "authentication_provider" => "auth.lt.bank",
  "attributes" => {
    "lt-personal-code" => "XXXXXXXXXXX"
  },
  "user_information" => {
    "firstName" => "VARDENIS",
    "lastName" => "PAVARDENIS",
    "companyName" => nil
  },
  "custom_data" => "correlation-123",
  "source_data" => {
    "type" => "BANKLINK",
    "parameters" => {
      "VK_USER" => "12345678900",
      "VK_TIME" => "08:57:29"
    }
  }
}
```

### Overriding configuration

When fetching ticket you can override some configuration attributes

```ruby
ticket = VIISP::Auth.ticket(
  postback_url: 'https://localhost',
  providers: %w[auth.lt.identity.card auth.lt.bank],
  attributes: %w[lt-personal-code lt-company-code],
  user_information: %w[firstName lastName companyName email],
)
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/laurynas/viisp-auth. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the VIISP::Auth project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/laurynas/viisp-auth/blob/master/CODE_OF_CONDUCT.md).
