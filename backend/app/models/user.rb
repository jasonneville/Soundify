class User < ApplicationRecord
  USERNAME_MAX_LENGTH = 15
  USERNAME_MIN_LENGTH = 4

  has_many :playlists, dependent: :destroy

  validates :password, presence: true
  validates :email, presence: true, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i }
  validates :first_name, presence: true, format: { with: /\A([^\d\W]|[-]|['])+\z/ }
  validates :last_name, presence: true, format: { with: /\A([^\d\W]|[-]|['])+\z/ }
  validates :username, presence: true, length: { maximum: USERNAME_MAX_LENGTH, minimum: USERNAME_MIN_LENGTH }

  def self.user_exists?(email, username)
    if User.exists?(username: username) or User.exists?(email: email)
      return true
    else
      return false
    end
  end
end
