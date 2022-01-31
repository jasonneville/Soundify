module PlaylistServices
  class CreatePlaylist
    def initialize(name, user)
      @name = name
      @user = user
    end
    
    # Creates a playlist 
    #
    # @returns [OpenStruct] - Returns created playlist, errors otherwise.
    def execute
      if @user.playlists.exists?(name: @name)
        return OpenStruct.new(success?: false, playlist: nil, errors: "User already has playlist with this name")
      else
        playlist = Playlist.new({ name: @name, user: @user })
        if playlist.save!
          return OpenStruct.new(success?: true, playlist: playlist, errors: nil)
        else
          return OpenStruct.new(success?: false, playlist: nil, errors: playlist.errors)
        end
      end
    end
  end
end
