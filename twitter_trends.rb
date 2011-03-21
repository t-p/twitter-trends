require 'rubygems'
require 'twitter'
require 'sinatra'
require 'haml'

before do
  @trend = Twitter.local_trends(638242)
end

get '/' do
  haml :index
end
