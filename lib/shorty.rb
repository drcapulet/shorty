require 'httparty'
require 'crack'

module Shorty
  class API
    include HTTParty
  end
  
  require File.dirname(__FILE__) + '/shorty/trim'
  require File.dirname(__FILE__) + '/shorty/bitly'
  require File.dirname(__FILE__) + '/shorty/tinyurl'
  require File.dirname(__FILE__) + '/shorty/isgd'
  require File.dirname(__FILE__) + '/shorty/cligs'
  require File.dirname(__FILE__) + '/shorty/twurl'
  require File.dirname(__FILE__) + '/shorty/supr'
end

