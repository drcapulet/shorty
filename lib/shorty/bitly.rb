module Shorty
  # The bit.ly API class. API documentation: http://code.google.com/p/bitly-api/wiki/ApiDocumentation
  # For testing, use:
  #   require 'lib/shorty'
  #   bitly = Shorty::Bitly.new('bitlyapidemo', 'R_0da49e0a9118ff35f52f629d2d71bf07')
  class Bitly
    attr_reader :options
    include HTTParty
    
    # Standard Error Class
    class Error < StandardError; end
    
    API_URL = 'api.bit.ly'
    API_VERSION = '2.0.1'
    base_uri API_URL
    
    # Options to pass:
    #
    # - login
    # - apikey
    def initialize(login, apikey)
      @options = {
        :login => login,
        :apiKey => apikey,
        :version => API_VERSION
      }
    end
    
    # shorten, pass:
    #
    # - longurl: the URL to be shortened
    def shorten( longurl )
      query = {:longUrl => longurl}
      query.merge!(@options)
      short = self.class.get('/shorten', :query => query)
      short = Crack::JSON.parse(short)
      short["errorCode"].zero? ? short["results"][longurl]["shortUrl"] : raise_error(short["errorCode"], short["errorMessage"])
    end
    
    # expand- given a bit.ly url, returns long source url, takes:
    #
    # - shorturl: the bit.ly url, can either be the full url or missing http://bit.ly
    def expand(shorturl)
      shorturl = gsub_url(shorturl)
      query = {:hash => shorturl}
      query.merge!(@options)
      expand = self.class.get('/expand', :query => query)
      expand = Crack::JSON.parse(expand)
      expand["errorCode"].zero? ? expand["results"][shorturl]["longUrl"] : raise_error(expand["errorCode"], expand["errorMessage"])
    end
    
    # info - Given a bit.ly url or hash, return information about that page, such as the long source url, ...
    def info(urlorhash, keys = [])
      urlhash = gsub_url(urlorhash)
      if keys != []
        query = {:hash => urlhash, :keys => keys.join(',')}
      else
        query = {:hash => urlhash}
      end
      query.merge!(@options)
      stats = self.class.get('/info', :query => query)
      stats = Crack::JSON.parse(stats)
      stats["errorCode"].zero? ? stats["results"][urlhash] : raise_error(stats["errorCode"], stats["errorMessage"])
    end
    
    # stats - get stats on clicks and reffers, pass either:
    #
    # - shortURL: A single bitly url, eg: http://bit.ly/1RmnUT
    # - hash: A single hash, eg: 1RmnUT
    #
    # Example:
    #   bitly = Shorty::Bitly.new('login', 'apikey')
    #   bitly.expand('1RmnUT')
    # Or:
    #   bitly = Shorty::Bitly.new('login', 'apikey')
    #   bitly.expand('http://bit.ly/1RmnUT')
    def stats(urlorhash)
      urlhash = gsub_url(urlorhash)
      query = {:hash => urlhash}
      query.merge!(@options)
      stats = self.class.get('/stats', :query => query)
      stats = Crack::JSON.parse(stats)
      stats["errorCode"].zero? ? stats["results"] : raise_error(stats["errorCode"], stats["errorMessage"])
    end
    
    
    protected
    
    def gsub_url(shorturl) 
      shorturl.split('/').last
      # shorturl = shorturl.gsub(/http:\/\//, '') if shorturl.include?('http://')
      # shorturl = shorturl.gsub(/bit.ly\//, '') if shorturl.include?('bit.ly/')
    end  
    
    def raise_error(code, message = '(no error message)')
      error = message + " (error code: #{code})"
      raise Shorty::Bitly::Error, error
    end
    
  end
end