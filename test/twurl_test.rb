require 'test_helper'

class TwurlTest < Test::Unit::TestCase
  context "Using twurl.nl" do
    setup do
      FakeWeb.register_uri(:post, "http://tweetburner.com/links?link[url]=http%3A%2F%2Fgoogle.com", :body => File.join(File.dirname(__FILE__), 'fixtures', 'twurl-shorten-google.txt'))
    end
        
    should "return a shortened url (class method)" do
      assert_equal 'http://twurl.nl/jnlwyb', Shorty::Twurl.shorten('http://google.com')
    end
      
    should "return a shortened url (instance method)" do
      @twurl = Shorty::Twurl.new
      assert_equal 'http://twurl.nl/jnlwyb', @twurl.shorten('http://google.com')
    end
  end  
end
