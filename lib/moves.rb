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
      format = "%Y-%m-%d"

      extra_path, params =
        if args[0].is_a?(Hash)
          ["", args[0]]
        elsif args[0].respond_to?(:strftime)
          ["/#{args[0].strftime(format)}", args[1]]
        elsif args[0].is_a?(Range)
          ["", {:from => args[0].first, to: args[0].last}]
        elsif args.compact.empty?
          ["", nil]
        else
          ["/#{args[0]}", args[1]]
        end
      params ||= {}

      # default to current day
      if extra_path.empty? and !(params[:to] or params[:from])
        extra_path = "/#{Time.now.strftime(format)}"
      end

      if params[:to].respond_to?(:strftime)
        params[:to] = params[:to].strftime(format)
      end

      if params[:from].respond_to?(:strftime)
        params[:from] = params[:from].strftime(format)
      end

      get "#{path}#{extra_path}", params
    end
  end
end
