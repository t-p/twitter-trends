require 'rubygems'
require 'twitter'
require 'sinatra'
require 'haml'


get '/' do
  haml :index
end

get '/:page' do
  @page = Twitter::Search.new.q(params[:page]).fetch
  haml :show
end

def trend
  Twitter.local_trends(23424829)
end

def find_trend(trend)
  
end
