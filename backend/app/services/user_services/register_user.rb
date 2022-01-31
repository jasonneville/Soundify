module UserServices
  class RegisterUser
    def initialize(user)
      @user = user
    end

    # Creates a user.
    #
    # @returns [OpenStruct] - Returns created user, errors otherwise.
    def execute
      if !User.user_exists?(@user.email, @user.username)
        library = nil
        ActiveRecord::Base.transaction do
          @user.save!
          library = PlaylistServices::CreatePlaylist.new('Library', @user).execute

          unless library.success?
            @user.errors = library.errors
            raise ActiveRecord::Rollback
          end
        end
        if library.success?
          return OpenStruct.new(success?: true, user: @user, errors: nil)
        else
          return OpenStruct.new(success?: false, user: nil, errors: @user.errors)
        end
      else
        return OpenStruct.new(success?: false, user: nil, errors: "User already exists")
      end
    end
  end
end
