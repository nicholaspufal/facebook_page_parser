#encoding: utf-8

require 'httparty'
require 'facebookparser/exceptions'

class FacebookParser
  include HTTParty
  extend ErrorHandler
  
  attr_reader :page
  
  def initialize(page)
    @page = parse_url(page)
  end
  
  def parse_url(url)
    url = url.gsub(/http:\/\/www.facebook.com\//,"")
    id = (url.match(/(pages)+/)) ? url.split("/").last : url  
    "https://graph.facebook.com/#{id}"
  end
  
  def get
    request = self.class.get(@page)
    
    if request.success?
      request
    else
      self.class.handle_failure(request.response) 
    end
  end
end

