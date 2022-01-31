module SpotifyServices
  class GetTrack
    def initialize(track_id, auth_token)
      @track_id = track_id
      @auth_token = auth_token
    end

    # Retrieves a spotify track.
    #
    # @returns [JSON] - Returns retrieved JSON from request.
    def execute
      url = Constants::UrlConstants::SPOTIFY_BASE_API_URL + 'tracks/' + @track_id
      bearer_token = 'Bearer ' + @auth_token
      headers = { 'Authorization' => bearer_token, 'Content-Type' => 'application/json' }
      response = Requests::GetRequest.new(url, headers).execute

      return response
    end
  end
end
