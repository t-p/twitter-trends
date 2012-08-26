require 'rubygems'
require 'twitter'
require 'sinatra'
require 'haml'

set :haml, :format => :html5

helpers do
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

private

def trend
  Twitter.local_trends(23424829)
end

def search(query)
  Twitter.search(query, :rpp => 15, :result_type => 'recent', :lang => 'de').results
end
