require 'rubygems'
require 'bundler'

Bundler.require

require './twitter_trends'
run Sinatra::Application
