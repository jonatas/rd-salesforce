# Rd::Salesforce

Integrates with salesforce allowing to add people as leads.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rd-salesforce'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rd-salesforce

## Usage

These library consists basically in:

* [client.rb](/lib/rd/salesforce/client.rb) - wraps the [RestForce api](https://github.com/ejholmes/restforce) and authentication info.
* [person.rb](/lib/rd/salesforce/person.rb) - stores and validates the person/lead info

### Setup a client

You can use the same [RestForce params to authentication](https://github.com/ejholmes/restforce#oauth-token-authentication) to the client:


```ruby
@client = Rd::Salesforce::Client.new instance_url: "https://xx.salesforce.com",
  oauth_token: "xxxxx...."
```

### Instance a person

```ruby
@person = Rd::Salesforce::Person.new
@person.first_name = "Jônatas"
@person.last_name = "Paganini"
@person.email = "jonatasdp@gmail.com"
```

You can see all the attributes at [person.rb](/lib/rd/salesforce/person.rb).

### Upload person to salesforce with the client

```ruby
@person.upload_to_salesforce! @client
```

## Setting up a different translation to salesforce fields

You can manage/override the fields connection that will be sent to salesforce via managing the translate hash.


```ruby
Rd::Salesforce::Person.translate = {
  :first_name => "FirstName",
  :last_name => "LastName",
  :email => "Email",
  :company => "Company",
  :website => "Website",
  :job_title => "Title",
  :phone => "Phone"
}
```

Or simple avoid send one attribute.

```ruby
Rd::Salesforce::Person.translate.delete :job_title
```


## Contributing

1. Fork it ( https://github.com/jonatas/rd-salesforce/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
