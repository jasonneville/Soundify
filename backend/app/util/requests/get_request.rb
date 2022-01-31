module Requests
  class GetRequest
    def initialize(url, headers)
      @url = url
      @headers = headers
    end
    # Sends a get request to the specified url.
    #
    # @returns [JSON] - Returns returned JSON from request.
    def execute
      response = HTTParty.get(@url, :headers => @headers)
      return response
    end
  end
end
