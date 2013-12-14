require 'sinatra/base'
require 'rubygems'
require 'twitter'
require 'haml'

class TwitterTrends < Sinatra::Base
  set :haml, :format => :html5

  before do
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
      config.consumer_secret     = ENV["TWITTER_CONSUMER_SECRET"]
      config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
      config.access_token_secret = ENV["TWITTER_ACCESS_SECRET"]
    end
  end

  helpers do
    def trends
      @client.local_trends(23424829).attrs[:trends]
    end

    def search_trend(trend)
      @client.search(trend, :rpp => 15, :result_type => 'recent').attrs[:statuses]
    end

    def parse_for_url(text)
      # The regex could probably still be improved, but this seems to do the
      # trick for most cases.
      text.gsub(/(https?:\/\/\w+(\.\w+)+(\/[\w\+\-\,\%]+)*(\?[\w\[\]]+(=\w*)?(&\w+(=\w*)?)*)?(#\w+)?)/i, '<a class="external" href="\1" target="_blank">\1</a>')
    end
  end

  get '/' do
    @tweets = @client.search(trends.first[:query])
    haml :show
  end

  get '/search/:show' do |trend|
    @tweets = search_trend(trend)
    haml :show
  end
end
