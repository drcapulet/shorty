
module Shorty
  # The tr.im API class. API documentation: http://tr.im/website/api
  class Trim
    include HTTParty
    attr_reader :options
    # API Error
    class APIError < StandardError; end
    class APIKeyInvalid < StandardError; end
    class APIKeyRequired < StandardError; end
    # Submitted URL Invalid.
    class URLInvalid < StandardError; end
    # Submitted URL is Already a Shortened URL.
    class AlreadyShortened < StandardError; end
    class URLMissing < StandardError; end
    class URLDoesntExist < StandardError; end
    class URLAlreadyClaimed < StandardError; end  
    # The URL has been Flagged as Spam and Rejected. 
    class FlaggedSpam < StandardError; end
    # The Custom tr.im URL Requested is Already in Us.
    class AlreadyInUse < StandardError; end
    class AuthenticationInvalid < StandardError; end
    class ReferenceCodeNonExistent< StandardError; end
    # Media
    class MediaTypeUnsupported < StandardError; end
    class MediaTooLarge < StandardError; end
    class MediaInvalidDimensions < StandardError; end
    # Invalid Errors
    class InvalidCharacters < StandardError; end
    class InvalidParameter < StandardError; end
    class UnknownError < StandardError; end
    # Required Parameter URL Not Submitted.
    class MissingParameter  < StandardError; end
    
    
    base_uri 'api.tr.im/api'

    # TODO: We should take the api_key, username and or password here and authenticate them if needed (need to look into that)
    def initialize(api_key = nil)
      @options = {}
      @options << {:api_key => api_key} if api_key
    end

    # The trim_simple API method as defined: http://tr.im/website/api#trim_simple
    # Can only be passed a site URL, only returns a URL, and no error handling occurs
    #   api = Shorty::Trim.new
    #   api.shorten('http://google.com') => http://tr.im/szMj
    def shorten( website_url )
      self.class.get( '/trim_simple', :query => { :url => website_url } )
    end
    
    
    # The trim_url API method as defined: http://tr.im/website/api#trim_url
    # The following options can be passed:
    #
    # - url: the URL you want to shorten
    # - custom: A custom URL that is preferred to an auto-generated URL.
    # - searchtags: A search string value to attach to a tr.im URL.
    # - privacycode: A string value that must be appended after the URL.
    # - newtrim: If present with any value, it will force the creation of a new tr.im URL.
    # - sandbox: If present with any value a test data set will be returned, and no URL created. This is intended for testing so that you do not consume API calls or insert pointless data while in development.
    #
    #   require 'shorty'
    #   api = Shorty::Trim.new
    #   api.trim_url(:url => 'http://google.com', :custom => 'thisismygoogle', :sandbox => 'true') # => http://tr.im/szMj
    
    def trim_url( options = {} )
      options.merge!(@options)
      response = self.class.get( '/trim_url.xml', :query => options )
      response = Crack::XML.parse(response)
      raise_error(response['trim']['status']['code'], response['trim']['status']['message']) if response['trim']['status']['code'] >= '205'
      return response['trim']['url']
    end
    
    TRIM_ERRORS = {
      400 => Shorty::Trim::MissingParameter, # Required Parameter URL Not Submitted.
      401 => Shorty::Trim::URLInvalid, # Submitted URL Invalid.
      402 => Shorty::Trim::AlreadyShortened, # Submitted URL is Already a Shortened URL.
      403 => Shorty::Trim::FlaggedSpam, # The URL has been Flagged as Spam and Rejected.
      404 => Shorty::Trim::AlreadyInUse, # The Custom tr.im URL Requested is Already in Us.
      405 => Shorty::Trim::InvalidCharacters, # Requested Custom URL Contains Invalid Characters.
      406 => Shorty::Trim::InvalidCharacters, # Requested Privacy Code Contains Invalid Characters.
      407 => Shorty::Trim::InvalidCharacters, # Requested Search Tags Contains Invalid Characters.
      410 => Shorty::Trim::AuthenticationInvalid, # Required Authentication Not Submitted or Invalid.
      411 => Shorty::Trim::MissingParameter, # URL Reference Code Not Submitted.
      412 => Shorty::Trim::ReferenceCodeNonExistent, # URL Reference Code Not Does Not Exist.
      413 => Shorty::Trim::URLMissing, # tr.im URL Path Not Submitted.
      414 => Shorty::Trim::URLDoesntExist, # tr.im URL Does Not Exist.
      415 => Shorty::Trim::URLAlreadyClaimed, # tr.im URL Referenced Already Claimed.
      420 => Shorty::Trim::MediaTypeUnsupported, # Media Type Uploaded Not Supported.
      421 => Shorty::Trim::MediaTooLarge, # Media Uploaded too Large.
      422 => Shorty::Trim::MediaInvalidDimensions, # Media Uploaded XY Dimensions too Small.
      425 => Shorty::Trim::APIError, # API Rate Limit Exceeded.
      426 => Shorty::Trim::APIKeyInvalid, # API Key Submitted Does Not Exist or is Invalid.
      427 => Shorty::Trim::APIKeyRequired, # API Key Required.
      445 => Shorty::Trim::InvalidParameter, # Parameter Data Within the Request is Invalid.
      446 => Shorty::Trim::MissingParameter, # "Required Parameter Missing within the Request."
      450 => Shorty::Trim::UnknownError # "An Unknown Error Occurred. Please email api@tr.im." 
    }
    
    private
    # Raise an error depending on the problem
    def raise_error(code, message = '(no error message)')
      # raise Shorty::Trim::APIError.new(TRIM_ERRORS[code])
      raise TRIM_ERRORS[code], message
    end
  end
end


