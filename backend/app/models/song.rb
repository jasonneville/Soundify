class Song < ApplicationRecord
  has_many :playlist_songs, dependent: :destroy
  has_many :playlists, -> { distinct }, through: :playlist_songs

  validates :name, presence: true
  validates :duration, presence: true
end
