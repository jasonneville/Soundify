module PlaylistServices
  class DeletePlaylist
    def initialize(playlist, current_user)
      @playlist = playlist
      @current_user = current_user
    end

    # Deletes a playlist 
    #
    # @returns [OpenStruct] - Returns success message, errors otherwise.
    def execute
      if @playlist.user = @current_user
        if @playlist.name == 'Library'
          return OpenStruct.new(success?: false, errors: "User cannot delete library")
        else
          @playlist.destroy
          return OpenStruct.new(success?: true, errors: nil)
        end
      else
        return OpenStruct.new(success?: false, errors: "User is not the owner of the playlist")
      end
    end
  end
end
