require 'rubygems'
require 'twitter'
require 'sinatra'
require 'haml'

set :haml, :format => :html5

helpers do

  def trend
    Twitter.local_trends(23424829)
  end
end

get '/' do
  haml :index
end

get '/:show' do |tweets|
  @page = Twitter::Search.new.q(tweets).language("de").fetch
  haml :show
end
