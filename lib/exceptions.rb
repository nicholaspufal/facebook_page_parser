#encoding: utf-8

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
          message = "Falha na autenticação. Http status 401" 
          raise AuthenticationFailedError, message 
        when "403" 
          message = "Acesso não autorizado. Http status 403" 
          raise UnauthorizedAccessError, message 
        when "404" 
          message = "Recurso não encontrado. Http status 404" 
          raise ResourceNotAvailableError, message 
        when "500" 
          message = "O web service reportou um erro interno. Http status 500" 
          raise UnknownServerError, message 
        else 
          message = "Web Service indisponível - erro não identificado. Http status #{response.code}" 
          raise WebServiceNotAvailableError, message  
      end 
  end
end
