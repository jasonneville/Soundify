module Requests
  class PostRequest
    def initialize(url, body, params, headers)
      @url = url
      @body = body
      @params = params
      @headers = headers
    end
    # Sends a post request with given url, params, headers, and body.
    #
    # @returns [JSON] - Returns JSON from post request.
    def execute
      response = nil
      if @body.nil?
        response = HTTParty.post(@url, :query => @params, :headers => @headers)
      else
        response = HTTParty.post(@url, :body => @body, :headers => @headers)
      end
      return response
    end
  end
end
