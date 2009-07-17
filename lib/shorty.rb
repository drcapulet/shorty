require 'httparty'
require 'crack'

module Shorty
  class API
    include HTTParty
  end
  
  require File.dirname(__FILE__) + '/shorty/trim'
  require File.dirname(__FILE__) + '/shorty/bitly'
end

