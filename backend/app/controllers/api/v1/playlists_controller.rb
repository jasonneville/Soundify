module Api
  module V1
    class PlaylistsController < ApplicationController
      before_action :set_playlist, only: %i[show destroy update add_song get_songs]
      skip_before_action :authenticate_request, only: %i[show]

      # Creates a new playlist for the current user.
      #
      # @render [JSON] - Created playlist if successful, errors otherwise.
      def create
        result = PlaylistServices::CreatePlaylist.new(params[:name], current_user).execute

        if result.success?
          render json: result.playlist, status: :created
        else
          render json: { message: result.errors }, status: :bad_request
        end
      end

      # Deletes the specified playlist for the current user.
      #
      # @render [JSON] - Empty content if successful, errors otherwise.
      def destroy
        result = PlaylistServices::DeletePlaylist.new(@playlist, current_user).execute

        if result.success?
          head :no_content
        else
          render json: { message: result.errors }, status: :forbidden
        end
      end

      # Retrieves all songs from the specified playlist.
      #
      # @render [[JSON]] - Retrieved songs if successful, errors otherwise.
      def get_songs
        render json: @playlist.songs, status: :ok
      end

      # Adds a song to the specified playlist.
      #
      # @render [JSON] - No content if successful, errors otherwise.
      def add_song
        result = PlaylistServices::AddSong.new(song_params, @playlist, current_user).execute

        if result.success?
          head :no_content
        else
          render json: { message: result.errors }, status: :bad_request
        end
      end

      # Updates a playlist's information.
      #
      # @render [JSON] - No content if successful, errors otherwise.
      def update
        result = PlaylistServices::UpdatePlaylist.new(playlist_params, @playlist, current_user).execute

        if result.success?
          head :no_content
        else
          render json: { message: result.errors }, status: :bad_request
        end
      end
      # Retrieves the specified playlist.
      #
      # @render [JSON] - Retrieved playlist if successful, errors otherwise.
      def show
        render json: @playlist, status: :ok
      end

      private

      # Returns playlist required fields.
      def playlist_params
        params.require(:playlist).permit(:name)
      end

      # Returns song required fields.
      def song_params
        params.require(:song).permit(:platform, :source_id)
      end

      # Finds the corresponding playlist with its id.
      #
      # @return [Playlist] - the found [playlist] record, if successful.
      # @render [JSON] - 404 status if the user cannot be found.
      def set_playlist
        @playlist = Playlist.find(params[:id])
        render json: { message: I18n.t('application.alert.not_found') }, status: :not_found if @playlist.nil?
      end
    end
  end
end
