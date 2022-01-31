module Api
  module V1
    class UsersController < ApplicationController
      before_action :set_user, only: %i[show playlists]
      skip_before_action :authenticate_request, only: %i[create show dog]

      # Retrieves all users.
      #
      # @render [[JSON]] - JSON Array of users, if successful.
      def index
        render json: User.all, status: :ok
      end

      # Creates a new user.
      #
      # @render [JSON] - Created user if successful, otherwise returns errors.
      def create
        result = UserServices::RegisterUser.new(User.new(user_params)).execute

        if result.success?
          render json: result.user, status: :created
        else
          render json: { errors: result.errors }, status: :bad_request
        end
      end

      # Finds the corresponding user with its id.
      #
      # @render [JSON] - Retrieved user if successful, errors otherwise.
      def show
        render json: @user, status: :ok
      end

      # Retrieves the current user.
      #
      # @render [JSON] - Retrieved user if successful, errors otherwise.
      def me
        render json: current_user, status: :ok
      end

      # Retrieves the specified user's playlists.
      #
      # @render [JSON] - Retrieved playlists if successful, errors otherwise.
      def playlists
        render json: @user.playlists, status: :ok
      end

      private

      # Returns required fields for creation and updating 
      def user_params
        params.require(:user).permit(:email, :username, :first_name, :last_name, :password)
      end

      # Finds the corresponding user with its id.
      #
      # @return [User] - the found user record, if successful.
      # @render [JSON] - 404 status if the user cannot be found.
      def set_user
        @user = User.find(params[:id])
        render json: { message: I18n.t('application.alert.not_found') }, status: :not_found if @user.nil?
      end
    end
  end
end
