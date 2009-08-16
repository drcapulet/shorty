require 'test_helper'

class TinyurlTest < Test::Unit::TestCase
  context "Using tinyurl.com" do
    setup do
      FakeWeb.register_uri(:get, "http://tinyurl.com/api-create.php?url=http%3A%2F%2Fgoogle.com", :body => File.join(File.dirname(__FILE__), 'fixtures', 'tinyurl-shorten-google.txt'))
    end
        
    should "return a shortened url (class method)" do
      assert_equal 'http://tinyurl.com/2x6rgl', Shorty::Tinyurl.shorten('http://google.com')
    end
      
    should "return a shortened url (instance method)" do
      @tinyurl = Shorty::Tinyurl.new
      assert_equal 'http://tinyurl.com/2x6rgl', @tinyurl.shorten('http://google.com')
    end
  end  
end
