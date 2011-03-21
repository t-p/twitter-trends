require 'rubygems'
require 'twitter'
require 'sinatra'
require 'haml'

before do
  @trend = Twitter.local_trends(2487956)
end

get '/' do
  haml :index
end
