require 'test_helper'

class CligsTest < Test::Unit::TestCase
  context "A cli.gs instance" do
    setup do
      FakeWeb.register_uri(:get, "http://cli.gs/api/v1/cligs/create?url=http%3A%2F%2Fgoogle.com", :body => File.join(File.dirname(__FILE__), 'fixtures', 'cligs-shorten-google.txt'))
      @cligs = Shorty::Cligs.new
    end
    
    should "exist" do
      assert @cligs
    end    
    
    should "return a shortened url" do
      assert_equal 'http://cli.gs/g5nmE', @cligs.shorten('http://google.com')
    end
  end
end
