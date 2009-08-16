module Shorty
  # The cli.gs API class. API documentation: http://blog.cli.gs/api
  # For testing, use:
  #   require 'lib/shorty'
  #   cligs = Shorty::Cligs.new
  class Cligs
    attr_reader :options
    include HTTParty
    
    # Standard Error Class
    class Error < StandardError; end
    
    API_URL = 'http://cli.gs/api/v1/cligs'
    API_VERSION = '1'
    base_uri API_URL
    
    # Options to pass:
    #
    # - API key: f given it associates the new clig with a user account so that they can view the traffic statistics. If not given, then a Public clig is created.
    # - AppId: a simple string, HTML allowed, that identifies your App when the API usage is listed in the user’s control panel. Keep it short and simple please.
    #
    #     cligs = Shorty::Cligs.new(:apikey => 'apikey', :appid => 'appid')
    def initialize(options = {})
      @options = {}
      @options[:key] = options[:apikey] if options[:apikey]
      @options[:appid] = options[:appid] if options[:appid]
    end
    
    # shorten. pass:
    #
    # - url: the url to shorten
    def shorten(url)
      query = {:url => url}
      query.merge!(@options)
      self.class.get('/create', :query => query)
    end
    
    # expand. pass either:
    #
    # - A valid clig ID, like Ts8p6Y
    # - A clig URL, like http://cli.gs/Ts8p6Y
    # 
    # Currently not implemented due to the fact this method wont work for demo.
    def expand(urlorhash)
      raise StandardError, 'Method not implemented'
    end
    
    protected
    
    def raise_error(code, message = '(no error message)')
      error = message + " (error code: #{code})"
      raise Shorty::Bitly::Error, error
    end
    
  end
end