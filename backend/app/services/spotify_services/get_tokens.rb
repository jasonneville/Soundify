require 'base64'
require 'uri'

module SpotifyServices
  class GetTokens
    def initialize(session_id, access_code)
      @session_id = session_id
      @access_code = access_code
    end

    # Retrieves the access token and refresh token for spotify oauth.
    #
    # @returns [OpenStruct] - Returns updated user, errors otherwise.
    def execute
      user = User.find_by(session_id: @session_id)
      url = Constants::UrlConstants::SPOTIFY_ACCOUNTS_URL + 'api/token'
      body = {
        grant_type: 'authorization_code',
        code: @access_code,
        redirect_uri: ENV.fetch('SPOTIFY_REDIRECT_URI')
      }
      base_64_string = "#{ENV.fetch('SPOTIFY_CLIENT_ID')}:#{ENV.fetch('SPOTIFY_SECRET_KEY')}"
      base_64_encoded_string = Base64.strict_encode64(base_64_string)
      headers = {
        'Authorization': "Basic #{base_64_encoded_string}",
        'Content-Type': "application/x-www-form-urlencoded"
      }

      response = Requests::PostRequest.new(url, URI.encode_www_form(body), nil, headers).execute

      return OpenStruct.new(success?: false) unless response.code == 200

      response_body = response.to_h
      user.update!(
        spotify_access_token: response_body["access_token"],
        spotify_refresh_token: response_body["refresh_token"]
      )

      return OpenStruct.new(success?: true, user: user)
    end
  end
end
