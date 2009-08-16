module Shorty
  # The twurl.nl API class. API documentation: http://tweetburner.com/api
  class Twurl
    attr_reader :options
    include HTTParty
    
    # Standard Error Class
    class Error < StandardError; end
    
    API_URL = 'http://tweetburner.com'
    base_uri API_URL
    
    # shorten. pass:
    # - url: the url to be shortened
    # So to use:
    #   twurl = Shorty::Truwl.new
    #   twurl.shorten('http://google.com')
    def shorten(url)
      query = { :'link[url]' => url }
      self.class.post("/links", :query => query)
    end
    
    # Same as the shorten method, you can just call the following instead:
    #
    #    Shorty::Truwl.shorten('http://google.com')
    def self.shorten(url)
      query = { :'link[url]' => url }
      post("/links", :query => query)
    end

  end
end