require_relative "test_helper"
require "date"

class TestMoves < Minitest::Test

  def setup
    @client = Moves::Client.new(ENV["ACCESS_TOKEN"])
    @today = Time.now.strftime("%Y-%m-%d")
    @day = "2014-01-01"
    @week = "2014-W1"
    @month = "2014-01"
    @from_to = {:from => "2014-01-01", :to => "2014-01-07"}
    @time = Time.now
    @date_time = DateTime.now
    @date = Date.today
    @from_to_time = {:from => @time - 86400, :to => @time}
    @time_range = (@time - 86400)..@time
  end

  def test_profile
    profile = @client.profile
    assert_kind_of Hash, profile
  end

  def test_daily_summary
    assert_works @client.daily_summary
  end

  def test_daily_summary_day
    assert_works @client.daily_summary(@day)
  end

  def test_daily_summary_time
    assert_works @client.daily_summary(@time)
  end

  def test_daily_summary_date_time
    assert_works @client.daily_summary(@date_time)
  end

  def test_daily_summary_date
    assert_works @client.daily_summary(@date)
  end

  def test_daily_summary_week
    assert_works @client.daily_summary(@week)
  end

  def test_daily_summary_month
    assert_works @client.daily_summary(@month)
  end

  def test_daily_summary_from_to
    assert_works @client.daily_summary(@from_to)
  end

  def test_daily_summary_from_to_time
    assert_works @client.daily_summary(@from_to_time)
  end

  def test_daily_summary_time_range
    assert_works @client.daily_summary(@time_range)
  end

  def test_daily_summary_past_days
    assert_works @client.daily_summary(:pastDays => 31)
  end

  def test_daily_summary_updated_since
    assert @client.daily_summary(:updatedSince => Time.now - 86400)
  end

  def test_daily_activites
    assert_works @client.daily_activities
  end

  def test_daily_activites_day
    assert_works @client.daily_activities(@day)
  end

  def test_daily_activites_week
    assert_works @client.daily_activities(@week)
  end

  def test_daily_activities_from_to
    assert_works @client.daily_activities(@from_to)
  end

  def test_daily_places
    assert_works @client.daily_places
  end

  def test_daily_places_day
    assert_works @client.daily_places(@day)
  end

  def test_daily_places_week
    assert_works @client.daily_places(@week)
  end

  def test_daily_places_from_to
    assert_works @client.daily_places(@from_to)
  end

  def test_daily_storyline
    assert_works @client.daily_storyline
  end

  def test_daily_storyline_day
    assert_works @client.daily_storyline(@day)
  end

  def test_daily_storyline_week
    assert_works @client.daily_storyline(@week)
  end

  def test_daily_storyline_from_to
    assert_works @client.daily_storyline(@from_to)
  end

  def test_daily_storyline_track_points
    assert_works @client.daily_storyline(:trackPoints => true)
  end

  def test_daily_storyline_track_points_day
    assert_works @client.daily_storyline(@day, :trackPoints => true)
  end

  protected

  # TODO better tests

  def assert_works(actual)
    assert_operator actual.size, :>=, 1
  end

end
