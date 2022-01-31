module SpotifyServices
  class AuthorizeApp
    def initialize(current_user)
      @current_user = current_user
      @redirect_uri = ENV.fetch('SPOTIFY_REDIRECT_URI')
    end

    # Formats url for oauth request.
    #
    # @returns [String] - Returns spotify oauth authorization url.
    def execute
      url = Constants::UrlConstants::SPOTIFY_ACCOUNTS_URL + 'authorize'
      query_params = {
        response_type: 'code',
        client_id: ENV.fetch('SPOTIFY_CLIENT_ID'),
        redirect_uri: @redirect_uri,
        scope: "user-library-read
        playlist-read-collaborative
        playlist-modify-private
        user-modify-playback-state
        user-read-private
        user-top-read
        playlist-modify-public",
        state: @current_user.session_id
      }
      return "#{url}?#{query_params.to_query}"
    end
  end
end
