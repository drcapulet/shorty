require 'test_helper'

class SuprTest < Test::Unit::TestCase
  context "A su.pr instance" do
    setup do
      FakeWeb.register_uri(:get, "http://su.pr/api/shorten?version=1.0&longUrl=http%3A%2F%2Fcnn.com", :body => File.join(File.dirname(__FILE__), 'fixtures', 'supr-shorten-cnn.json'))
      FakeWeb.register_uri(:get, "http://su.pr/api/shorten?longUrl=http%3A%2F%2Fcnn.com", :body => File.join(File.dirname(__FILE__), 'fixtures', 'supr-shorten-cnn.json'))
      FakeWeb.register_uri(:get, "http://su.pr/api/expand?hash=2yw2PP&version=1.0", :body => File.join(File.dirname(__FILE__), 'fixtures', 'supr-expand-cnn.json'))
      FakeWeb.register_uri(:get, "http://su.pr/api/expand?hash=2yw2PP", :body => File.join(File.dirname(__FILE__), 'fixtures', 'supr-expand-cnn.json'))
      FakeWeb.register_uri(:get, "http://su.pr/api/expand?hash=15DlK&version=1.0", :body => File.join(File.dirname(__FILE__), 'fixtures', 'supr-expand-cnn-error.json'))
      FakeWeb.register_uri(:get, "http://su.pr/api/expand?hash=15DlK", :body => File.join(File.dirname(__FILE__), 'fixtures', 'supr-expand-cnn-error.json'))
    end
    
    context "when using instance methods" do
      setup do
        @supr = Shorty::Supr.new
      end
      
      should "exist" do
        assert @supr
      end
      
      should "return a shortened url" do
        assert_equal 'http://su.pr/2yw2PP', @supr.shorten('http://cnn.com')
      end

      should "return an expanded url when passed a hash" do
        assert_equal 'http://cnn.com/', @supr.expand('2yw2PP')
      end

      should "return an expanded url when passed a full url" do
        assert_equal 'http://cnn.com/', @supr.expand('http://su.pr/2yw2PP')
      end
      
      should "raise an error when passed an invalid hash to expand" do
        assert_raise Shorty::Supr::Error do
          @supr.expand('15DlK')
        end
      end
      
      should "raise an error when an instance is being created and is missing a paramter" do
        assert_raise Shorty::Supr::Error do
          Shorty::Supr.new('dummyapi')
        end
      end
    end
    
    context "when using class methods" do
      should "return a shortened url" do
        assert_equal 'http://su.pr/2yw2PP', Shorty::Supr.shorten('http://cnn.com')
      end
      
      should "return a shortened hash" do
        assert_equal '2yw2PP', Shorty::Supr.shorten('http://cnn.com', false)
      end

      should "return an expanded url when passed a hash" do
        assert_equal 'http://cnn.com/', Shorty::Supr.expand('2yw2PP')
      end

      should "return an expanded url when passed a full url" do
        assert_equal 'http://cnn.com/', Shorty::Supr.expand('http://su.pr/2yw2PP')
      end
      
      should "return an error when passed an invalid hash to expand" do
        assert_raise Shorty::Supr::Error do
          Shorty::Supr.expand('15DlK')
        end
      end
    end

  end
end
