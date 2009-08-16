require 'httparty'
require 'crack'

module Shorty
  class API
    include HTTParty
  end
  
  require 'shorty/trim'
  require 'shorty/bitly'
  require 'shorty/tinyurl'
  require 'shorty/isgd'
  require 'shorty/cligs'
  require 'shorty/twurl'
  require 'shorty/supr'
end

