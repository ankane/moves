require "test_helper"

class TestMoves < Minitest::Test

  def setup
    @client = Moves::Client.new(ENV["ACCESS_TOKEN"])
  end

  # TODO better tests

  def test_profile
    profile = @client.profile
    # p profile
    assert_kind_of Hash, profile
  end

  def test_daily_summary
    assert_works @client.daily_summary
  end

  def test_daily_activites
    assert_works @client.daily_activities
  end

  def test_daily_places
    assert_works @client.daily_places
  end

  def test_daily_storyline
    assert_works @client.daily_storyline
  end

  def test_daily_summary_from_to
    assert_works @client.daily_summary(:from => "2013-06-20", :to => "2013-06-23"), 4
  end

  def test_daily_activities_from_to
    assert_works @client.daily_activities(:from => "2013-06-20", :to => "2013-06-23"), 4
  end

  def test_daily_places_from_to
    assert_works @client.daily_places(:from => "2013-06-20", :to => "2013-06-23"), 4
  end

  def test_daily_storyline_from_to
    assert_works @client.daily_storyline(:from => "2013-06-20", :to => "2013-06-23"), 4
  end

  protected

  def assert_works(actual, expected_size = 1)
    # p actual
    assert_equal expected_size, actual.size
  end

end
