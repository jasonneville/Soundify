class Playlist < ApplicationRecord
  belongs_to :user
  has_many :playlist_songs, dependent: :destroy
  has_many :songs, -> { distinct }, through: :playlist_songs

  validates :name, presence: true
  validates :duration, presence: true
end
