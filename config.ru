require 'rubygems'
require 'bundler'

Bundler.require

require './fetch_flickr'
run Sinatra::Application
