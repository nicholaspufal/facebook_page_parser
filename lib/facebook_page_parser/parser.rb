#encoding: utf-8

require 'httparty'
require 'facebook_page_parser/exceptions'

module FacebookPageParser
  class Parser
    include HTTParty
    extend Exceptions
  
    attr_reader :page
  
    def initialize(page)
      @page = parse_url(page)
    end
  
    def parse_url(url)
      url = url.gsub(/(http:\/\/)?([a-z\-]+|www)?\.?facebook.com\//,"")
      id = (url.match(/(pages)+/)) ? url.split("/").last : url  
      "https://graph.facebook.com/#{id}"
    end
  
    #memoize request
    def request
      @request ||= self.class.get(@page)
    end
    
    def get
      if request.success?
        request
      else
        self.class.handle_failure(request.response) 
      end
    end
  end
end