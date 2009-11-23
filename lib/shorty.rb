require 'httparty'
require 'crack'
require 'ostruct'

module Shorty
  class SimpleAPI
    
    def shorten(url)
      self.class.get(self.class::API_URL, :query => self.class.prep_query(url))
    end
    
    def self.shorten(url)
      get(self::API_URL, :query => self.prep_query(url))
    end
  end
  
  require File.dirname(__FILE__) + '/shorty/to_openstruct'
  require File.dirname(__FILE__) + '/shorty/trim'
  require File.dirname(__FILE__) + '/shorty/bitly'
  require File.dirname(__FILE__) + '/shorty/tinyurl'
  require File.dirname(__FILE__) + '/shorty/isgd'
  require File.dirname(__FILE__) + '/shorty/cligs'
  require File.dirname(__FILE__) + '/shorty/twurl'
  require File.dirname(__FILE__) + '/shorty/supr'
end

