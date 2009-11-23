module Shorty
  # is.gd API as defined http://is.gd/api_info.php
  class Isgd < SimpleAPI
    include HTTParty
    
    API_URL = 'http://is.gd/api.php'
        
    def self.prep_query(url)
      {:longurl => url}
    end
  end
end