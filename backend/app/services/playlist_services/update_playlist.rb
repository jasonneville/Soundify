module PlaylistServices
  class UpdatePlaylist
    def initialize(params, playlist, user)
      @params = params
      @playlist = playlist
      @user = user
    end

    # Updates a playlist.
    #
    # @returns [OpenStruct] - Returns success message, errors otherwise.
    def execute
      if @playlist.user == @user
        if @playlist.name == 'Library'
          return OpenStruct.new(success?: false, errors: "Cannot change library name")
        else
          @playlist.update(@params)
          return OpenStruct.new(success?: true, errors: nil)
        end
      else
        return OpenStruct.new(success?: false, errors: "Forbidden")
      end
    end
  end
end
