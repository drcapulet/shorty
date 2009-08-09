require 'test_helper'

class TrimTest < Test::Unit::TestCase
  context "A tr.im instance" do
    setup do
      FakeWeb.register_uri(:get, "http://api.tr.im/api/trim_simple?url=http%3A%2F%2Fgoogle.com", :body => File.join(File.dirname(__FILE__), 'fixtures', 'trim-trim-simple.txt'))
      FakeWeb.register_uri(:get, "http://api.tr.im/api/trim_url.xml?url=http%3A%2F%2Fgoogle.com&custom=thisismygoogletesting", :body => File.join(File.dirname(__FILE__), 'fixtures', 'trim-trim-url.xml'))
      # FakeWeb.register_uri(:get, "http://api.bit.ly/stats?hash=15DlK&apiKey=R_0da49e0a9118ff35f52f629d2d71bf07&version=2.0.1&login=bitlyapidemo", :body => File.join(File.dirname(__FILE__), 'fixtures', 'bitly-stats-cnn.json'))
      @trim = Shorty::Trim.new
    end
    
    should "exist" do
      assert @trim
    end
    
    should "return a shortened url using trim_simple" do
      assert_equal 'http://tr.im/w5Pm', @trim.shorten('http://google.com')
    end
    
    should "return a shortened url using trim_url" do
      assert_equal 'http://tr.im/thisismygoogletesting', @trim.trim_url(:url => 'http://google.com', :custom => 'thisismygoogletesting')
    end
  end
end
