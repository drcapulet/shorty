module Shorty
  # The bit.ly API class. API documentation: http://code.google.com/p/bitly-api/wiki/ApiDocumentation
  class Bitly < API
    attr_reader :options
    
    basic_uri = 'api.bit.ly'
    
    def initialize(options)
      @options = {}
    end
    
    
  end
end