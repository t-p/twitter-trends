require 'rubygems'
require 'twitter'
require 'sinatra'
require 'haml'


get '/' do
  haml :index
end

def trend
  Twitter.trends_current
end
