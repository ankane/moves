require "moves/version"
require "json"
require "rest_client"

module Moves
  class Client
    attr_reader :access_token

    ENDPOINT = "https://api.moves-app.com/api/v1/"

    def initialize(access_token)
      @access_token = access_token
    end

    def profile
      get "user/profile"
    end

    def daily_summary(params = {})
      get_range "user/summary/daily", params
    end

    def daily_activities(params = {})
      get_range "user/activities/daily", params
    end

    def daily_places(params = {})
      get_range "user/places/daily", params
    end

    def daily_storyline(params = {})
      get_range "user/storyline/daily", params
    end

    protected

    def get(path, params = {})
      response = RestClient.get "#{ENDPOINT}#{path}", :params => {:access_token => @access_token}.merge(params)
      JSON.parse(response.body)
    end

    def get_range(path, params = {})
      today = Time.now.strftime("%Y-%m-%d")
      get path, {:to => today, :from => today}.merge(params)
    end

  end
end
