module Api
  module V1
    class AuthController < ApplicationController
      skip_before_action :authenticate_request, only: %i[login callback]

      # Callback url for the spotify oauth implementation. 
      #
      # @render [JSON] - Current user if successful, errors otherwise.
      def callback
        response = SpotifyServices::GetTokens.new(params[:state], params[:code]).execute

        if response.success?
          render json: response.user, status: :ok
        else
          render json: { message: "Error authenticating" }, status: :bad_request
        end
      end

      # Starts process for authorizing spotify application for the current user.
      def spotify_login
        response = SpotifyServices::AuthorizeApp.new(current_user).execute
        redirect_to response
      end

      # Logs in a User.
      #
      # @render [JSON] - Session id if successful, errors otherwise.
      def login
        login_keys = ['email', 'password']

        if login_keys.all? { |k| params.has_key? k }
          user = User.find_by(email: params[:email])
          if !user.present?
            render json: { message: "No user with email: #{params[:email]}" }, status: :forbidden
          elsif params[:password] == user.password
            uuid = SecureRandom.uuid
            user.session_id = uuid
            user.save
            render json: {jwt: uuid}, status: :ok
          else
            render json: { message: "Incorrect credentials" }, status: :forbidden
          end
        else
          render json: { message: "Must supply email and password" }, status: :bad_request
        end
      end
    end
  end
end
