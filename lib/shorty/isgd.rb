module Shorty
  # is.gd API as defined http://is.gd/api_info.php
  class Isgd
    include HTTParty
    
    def shorten(url)
      self.class.get('http://is.gd/api.php', :query => {:longurl => url})
    end
    
    def self.shorten(url)
      get('http://is.gd/api.php', :query => {:longurl => url})
    end
  end
end