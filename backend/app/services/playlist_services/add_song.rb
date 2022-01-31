module PlaylistServices
  class AddSong
    def initialize(song, playlist, user)
      @song_id = song[:source_id]
      @song_platform = song[:platform]
      @playlist = playlist
      @user = user
    end

    # Adds a song to the playlist.
    #
    # @returns [OpenStruct] - Returns success message, errors otherwise.
    def execute
      if @user == @playlist.user
        duplicate = false
        ActiveRecord::Base.transaction do
          song = Song.find_by(source_id: @song_id, platform: @song_platform)
          if !song
            song = Song.create!({ source_id: @song_id, platform: @song_platform, name: "Song", duration: 100,
                                  artist_name: "Artist" })
          end
          if @playlist.songs.exists?(id: song.id)
            duplicate = true
            raise ActiveRecord::Rollback
          end
          @playlist.songs << song
        end
        if duplicate
          return OpenStruct.new(success?: false, errors: "Song already in playlist")
        else
          return OpenStruct.new(success?: true, errors: nil)
        end
      else
        return OpenStruct.new(success?: false, errors: "User forbidden")
      end
    end
  end
end
