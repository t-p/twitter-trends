require 'sinatra/base'
require 'rubygems'
require 'twitter'
require 'haml'

class TwitterTrends < Sinatra::Base
  set :haml, :format => :html5

  helpers do
    def trend
      Twitter.local_trends(23424829)
    end

    def parse_for_url(text)
      # The regex could probably still be improved, but this seems to do the
      # trick for most cases.
      text.gsub(/(https?:\/\/\w+(\.\w+)+(\/[\w\+\-\,\%]+)*(\?[\w\[\]]+(=\w*)?(&\w+(=\w*)?)*)?(#\w+)?)/i, '<a class="external" href="\1" target="_blank">\1</a>')
    end
  end

  get '/' do
    @tweets = search(trend.first.query)
    haml :show
  end

  get '/search/:show' do |query|
    @tweets = search(query)
    haml :show
  end

  def search(query)
    Twitter.search(query, :rpp => 15, :result_type => 'recent', :lang => 'de').results
  end

  run!
end
