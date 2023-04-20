class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.string :body, null: false
      t.string :tag_list, null: false
      t.boolean :posted_flag, null: false, default: false
      t.string :latitude, null: false
      t.string :longitude, null: false

      t.timestamps
    end
  end
end
