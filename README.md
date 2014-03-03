# Moves

Ruby client for [Moves](https://dev.moves-app.com/docs/overview)

## Usage

Create a client.  To obtain an access token, we recommend the [omniauth-moves](https://github.com/nickelser/omniauth-moves) gem.

```ruby
moves = Moves::Client.new(access_token)
```

Get profile

```ruby
moves.profile
```

Get daily summary

```ruby
moves.daily_summary                  # current day
moves.daily_summary("2013-06-20")    # any day
moves.daily_summary("2013-W25")      # week
moves.daily_summary("2013-06")       # month
moves.daily_summary(:from => "2013-06-20", :to => "2013-06-23") # max 31 days

# also supports Time, Date, and DateTime objects
moves.daily_summary(Time.now)
moves.daily_summary(Date.today)
moves.daily_summary(DateTime.now)
moves.daily_summary((Date.today - 1)..Date.today)
```

Get daily activities

```ruby
moves.daily_activities               # current day
moves.daily_activities("2013-06-20") # any day
moves.daily_activities("2013-W25")   # week
moves.daily_activities(:from => "2013-06-20", :to => "2013-06-23") # max 7 days
```

Get daily places

```ruby
moves.daily_places                   # current day
moves.daily_places("2013-06-20")     # any day
moves.daily_places("2013-W25")       # week
moves.daily_places(:from => "2013-06-20", :to => "2013-06-23") # max 7 days
```

Get daily storyline

```ruby
moves.daily_storyline                # current day
moves.daily_storyline("2013-06-20")  # any day
moves.daily_storyline("2013-W25")    # week
moves.daily_storyline(:from => "2013-06-20", :to => "2013-06-23") # max 7 days
```

Get daily storyline with track points

```ruby
moves.daily_storyline(:trackPoints => true)               # current day
moves.daily_storyline("2013-06-20", :trackPoints => true) # any day
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
