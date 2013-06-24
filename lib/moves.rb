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

    def daily_summary(*args)
      get_range "user/summary/daily", *args
    end

    def daily_activities(*args)
      get_range "user/activities/daily", *args
    end

    def daily_places(*args)
      get_range "user/places/daily", *args
    end

    def daily_storyline(*args)
      get_range "user/storyline/daily", *args
    end

    protected

    def get(path, params = {})
      response = RestClient.get "#{ENDPOINT}#{path}", :params => {:access_token => @access_token}.merge(params)
      JSON.parse(response.body)
    end

    def get_range(path, *args)
      extra_path, params =
        if args[0].is_a?(String)
          ["/#{args[0]}", args[1]]
        else
          ["", args[0]]
        end
      params ||= {}

      # default to current day
      if extra_path.empty? and !(params[:to] or params[:from])
        extra_path = "/#{Time.now.strftime("%Y%m%d")}"
      end

      get "#{path}#{extra_path}", params
    end
  end
end
