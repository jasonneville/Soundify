class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users, id: :uuid do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :password, null: false
      t.string :username, null: false
      t.string :email, null: false
      t.string :spotify_access_token
      t.string :spotify_refresh_token
      t.uuid :session_id
      t.timestamps
    end
  end
end
