module Shorty
  # The tinyurl.com API. Not much here, undocumented API
  class Tinyurl
    include HTTParty
    
    def shorten(url)
      self.class.get('http://tinyurl.com/api-create.php', :query => {:url => url})
    end
    
    def self.shorten(url)
      get('http://tinyurl.com/api-create.php', :query => {:url => url})
    end
  end
end