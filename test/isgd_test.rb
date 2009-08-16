require 'test_helper'

class IsgdTest < Test::Unit::TestCase
  context "Using is.gd" do
    setup do
      FakeWeb.register_uri(:get, "http://is.gd/api.php?longurl=http%3A%2F%2Fgoogle.com", :body => File.join(File.dirname(__FILE__), 'fixtures', 'isgd-shorten-google.txt'))
    end
        
    should "return a shortened url (class method)" do
      assert_equal 'http://is.gd/2iE2G', Shorty::Isgd.shorten('http://google.com')
    end   
    
    should "return a shortened url (instance method)" do
      @isgd = Shorty::Isgd.new
      assert_equal 'http://is.gd/2iE2G', @isgd.shorten('http://google.com')
    end
  end 
end
