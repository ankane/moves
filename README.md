# Moves

Ruby client for [Moves](https://dev.moves-app.com/docs/overview)

## Usage

Create a client.  To obtain an access token, we recommend the [omniauth-moves](https://github.com/nickelser/omniauth-moves) gem.

```ruby
client = Moves::Client.new(access_token)
```

Get profile

```ruby
client.profile
```

Get daily summary

```ruby
client.daily_summary                  # current day
client.daily_summary("2013-06-20")    # any day
client.daily_summary("2013-W25")      # week
client.daily_summary("2013-06")       # month
client.daily_summary(:from => "2013-06-20", :to => "2013-06-23") # max 31 days

# also supports Time, Date, and DateTime objects
client.daily_summary(Time.now)
client.daily_summary(Date.today)
client.daily_summary(DateTime.now)
client.daily_summary((Date.today - 1)..Date.today)
```

Get daily activities

```ruby
client.daily_activities               # current day
client.daily_activities("2013-06-20") # any day
client.daily_activities("2013-W25")   # week
client.daily_activities(:from => "2013-06-20", :to => "2013-06-23") # max 7 days
```

Get daily places

```ruby
client.daily_places                   # current day
client.daily_places("2013-06-20")     # any day
client.daily_places("2013-W25")       # week
client.daily_places(:from => "2013-06-20", :to => "2013-06-23") # max 7 days
```

Get daily storyline

```ruby
client.daily_storyline                # current day
client.daily_storyline("2013-06-20")  # any day
client.daily_storyline("2013-W25")    # week
client.daily_storyline(:from => "2013-06-20", :to => "2013-06-23") # max 7 days
```

Get daily storyline with track points

```ruby
client.daily_storyline(:trackPoints => true)               # current day
client.daily_storyline("2013-06-20", :trackPoints => true) # any day
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem "moves"
```

And then execute:

```sh
bundle
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
