class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :body
      t.string :tag_list
      t.boolean :posted_flag, null: false, default: false
      t.string :latitude
      t.string :longitude
      t.integer :tag_id
      t.integer :user_id

      t.timestamps
    end
  end
end
