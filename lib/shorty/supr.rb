module Shorty
  # The su.pr API class. API documentation: http://www.stumbleupon.com/developers/Supr:API_documentation/
  class Supr
    attr_reader :options
    include HTTParty
    
    # Standard Error Class
    class Error < StandardError; end
    
    API_URL = 'http://su.pr/api'
    API_VERSION = '1.0'
    base_uri API_URL
    
    # Options to pass, optional, but both must be passed when used
    # - login: Your Su.pr username (also your StumbleUpon username)
    # - apikey: Your private API key. This can be generated on your Su.pr settings page.
    def initialize(login = nil, apikey = nil)
      @options = {
        :version => API_VERSION
      }
      if login && apikey
        @options.merge({:login => login, :apiKey => apikey})
      elsif (login || apikey)
        raise Shorty::Supr::Error, 'Both the API key and login values must be passed when you want to use authentication'
      end
    end
    
    # shorten. pass:
    # - url: The long URL you wish to shorten
    # Will return the full url unless you pass false for the second parameter, then it only returns the hash
    def shorten(url, full = true)
      query = self.class.prep_shorten_request(url)
      short = Crack::JSON.parse(self.class.get('/shorten', :query => query))
      self.class.handle_full_or_hash_option(short, url, full)
    end
    
    # self.shorten. see shorten
    def self.shorten(url, full = true)
      query = self.prep_shorten_request(url)
      short = Crack::JSON.parse(get('/shorten', :query => query))
      self.handle_full_or_hash_option(short, url, full)
    end
    
    # expand. pass either:
    # - shortUrl: he Su.pr URL you wish to expand
    # - hash: The six character hash you wish to expand
    def expand(urlorhash)
      query, hash = self.class.prep_expand_request(urlorhash)
      expand = Crack::JSON.parse(self.class.get('/expand', :query => query))
      expand["errorCode"].zero? ? expand["results"][hash]["longUrl"] : self.class.raise_error(expand)
    end
    
    # self.expand. see expand
    def self.expand(urlorhash)
      query, hash = self.prep_expand_request(urlorhash)
      expand = Crack::JSON.parse(get('/expand', :query => query))
      expand["errorCode"].zero? ? expand["results"][hash]["longUrl"] : self.raise_error(expand)
    end

        
    protected
    
    def self.gsub_url(shorturl) 
      shorturl.split('/').last
    end
    
    def self.raise_error(hash)
      code = hash["errorCode"]
      message = hash["errorMessage"] || '(no error message)'
      error = message + " (error code: #{code})"
      raise Shorty::Supr::Error, error
    end
    
    def self.handle_full_or_hash_option(short, url, full)
        short["errorCode"].zero? ? (full ? short["results"][url]["shortUrl"] : short["results"][url]["hash"]) : self.raise_error(short)
    end
    
    def self.prep_shorten_request(url)
      query = {:longUrl => url}
      query.merge!(@options) if @options
      query
    end
    
    def self.prep_expand_request(urlorhash)
      hash = self.gsub_url(urlorhash)
      query = {:hash => hash}
      query.merge!(@options) if @options
      [query, hash]
    end

  end
end