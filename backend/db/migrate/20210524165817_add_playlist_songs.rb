class AddPlaylistSongs < ActiveRecord::Migration[6.1]
  def change
    create_table :playlist_songs, id: :uuid do |t|
      t.belongs_to :playlist, type: :uuid, null: false
      t.belongs_to :song, type: :uuid, null: false
      t.timestamps
    end
  end
end
