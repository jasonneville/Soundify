class CreateSongs < ActiveRecord::Migration[6.1]
  def change
    create_table :songs, id: :uuid do |t|
      t.string :name, null: false
      t.string :platform, null: false
      t.string :source_id, null: false
      t.integer :duration, null: false
      t.string :artist_name, null: false
      t.timestamps
    end
  end
end
