#encoding: utf-8

module FacebookPageParser
  module Exceptions
    class AuthenticationFailedError < StandardError
    end

    class ResourceNotAvailableError < StandardError 
    end

    class UnauthorizedAccessError < StandardError
    end

    class UnknownServerError < StandardError
    end

    class WebServiceNotAvailableError < StandardError
    end
  
    def handle_failure(response)       
        case response.code
          when "401" 
            message = "Authentication failure. HTTP status 401" 
            raise AuthenticationFailedError, message 
          when "403" 
            message = "Unauthorized access. HTTP status 403" 
            raise UnauthorizedAccessError, message 
          when "404" 
            message = "Resource not found. HTTP status 404" 
            raise ResourceNotAvailableError, message 
          when "500" 
            message = "Web service reported an internal error. HTTP status 500" 
            raise UnknownServerError, message 
          else 
            message = "Web Service unavailable - unidentified error. HTTP status #{response.code}" 
            raise WebServiceNotAvailableError, message  
        end 
    end
  end
end
