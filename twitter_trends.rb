require 'rubygems'
require 'twitter'
require 'sinatra'
require 'haml'

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
  haml :index
end

get '/:show' do |tweets|
  @tweet = Twitter::Search.new.q(tweets).language("de").result_type("recent").no_retweets.fetch
  haml :show
end
