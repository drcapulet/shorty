module Shorty
  # The tinyurl.com API. Not much here, undocumented API
  class Tinyurl < SimpleAPI
    include HTTParty
    
    API_URL = 'http://tinyurl.com/api-create.php'
    
    def self.prep_query(url)
      {:url => url}
    end
  end
end