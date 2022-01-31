require 'base64'

module SpotifyServices
  class RefreshToken
    
    def initialize(refresh_token)
      @refresh_token = refresh_token
    end

    # Refreshes a user's spotify access token.
    #
    # @returns [JSON] - Returns JSON from post request.
    def execute
      url = Constants::UrlConstants::SPOTIFY_ACCOUNTS_URL + '/api/token'
      query_params = { grant_type: 'refresh_token', refresh_token: @refresh_token}
      base_64_string = ENV.fetch('SPOTIFY_CLIENT_ID')+ ':' + ENV.fetch('SPOTIFY_SECRET_KEY')
      base_64_encoded_string = Base64.encode64(base_64_string)
      headers = { Authorization: 'Basic #{base_64_encoded_string}', "content-type", "application/x-www-form-urlencoded"}
      response = Requests::PostRequest.new(url, nil, query_params, headers, false)
      return response
    end
  end
end