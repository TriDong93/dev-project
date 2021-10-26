class CreateShareVideos < ActiveRecord::Migration[6.0]
  def change
    create_table :share_videos do |t|
      t.string :url
      t.integer :user_id
      t.timestamps null: false
    end
  end
end
