#encoding: utf-8

require 'httparty'
require 'uri'
require 'facebook_page_parser/exceptions'

module FacebookPageParser
  class Parser
    include HTTParty
    extend Exceptions
  
    attr_reader :page
  
    def initialize(page)
      @page = parse_url(page)
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
    
    private
    
    def parse_url(url)
      url = URI(url).path
      id = url.split("/").last
      "https://graph.facebook.com/#{id}"
    end
    
  end
end