require 'rubygems'
require 'twitter'
require 'sinatra'
require 'haml'


get '/' do
  haml :index
end

def trend
  Twitter.local_trends(1)
end
