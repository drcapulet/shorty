require 'test_helper'

class BitlyTest < Test::Unit::TestCase
  context "A bit.ly instance" do
    setup do
      FakeWeb.register_uri(:get, "http://api.bit.ly/shorten?apiKey=R_0da49e0a9118ff35f52f629d2d71bf07&version=2.0.1&longUrl=http%3A%2F%2Fcnn.com&login=bitlyapidemo", :body => File.join(File.dirname(__FILE__), 'fixtures', 'bitly-shorten-cnn.json'))
      FakeWeb.register_uri(:get, "http://api.bit.ly/expand?apiKey=R_0da49e0a9118ff35f52f629d2d71bf07&version=2.0.1&login=bitlyapidemo&hash=15DlK", :body => File.join(File.dirname(__FILE__), 'fixtures', 'bitly-expand-cnn.json'))
      FakeWeb.register_uri(:get, "http://api.bit.ly/stats?hash=15DlK&apiKey=R_0da49e0a9118ff35f52f629d2d71bf07&version=2.0.1&login=bitlyapidemo", :body => File.join(File.dirname(__FILE__), 'fixtures', 'bitly-stats-cnn.json'))
      @bitly = Shorty::Bitly.new('bitlyapidemo', 'R_0da49e0a9118ff35f52f629d2d71bf07')
    end
    
    should "exist" do
      assert @bitly
    end
    
    should "return a shortened url" do
      assert_equal 'http://bit.ly/15DlK', @bitly.shorten('http://cnn.com')
    end
    
    should "return an expanded url when passed a hash" do
      assert_equal 'http://cnn.com/', @bitly.expand('15DlK')
    end
    
    should "return an expanded url when passed a full url" do
      assert_equal 'http://cnn.com/', @bitly.expand('http://bit.ly/15DlK')
    end
    
    should "return the stats for a url" do
      assert_equal 3046, @bitly.stats('http://bit.ly/15DlK')["clicks"]
    end
  end
end
