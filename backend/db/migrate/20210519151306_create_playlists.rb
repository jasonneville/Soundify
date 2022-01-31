class CreatePlaylists < ActiveRecord::Migration[6.1]
  def change
    create_table :playlists, id: :uuid do |t|
      t.string :name, null: false
      t.uuid :user_id, null: false
      t.integer :duration, null: false, :default => 0
      t.timestamps
    end
  end
end
