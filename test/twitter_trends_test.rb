require './twitter_trends'
require 'test/unit'
require 'rack/test'

ENV['RACK_ENV'] = 'test'

class TwitterTrendsTest < MiniTest::Unit::TestCase
  include Rack::Test::Methods

  def app
    TwitterTrends
  end

  def test_trend
    trends = Twitter.local_trends(23424829)
    assert_operator trends.length, :>, 0
  end

  def test_it_has_body
    get '/'
    assert last_response.ok?
    assert last_response.body.include?('twitter trends')
  end
end
