class AddColumnsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :self_introduction, :string, :null => false
    add_column :users, :is_deleted, :boolean, default: false, :null => false
    add_column :users, :latitude, :string, :null => false
    add_column :users, :longitude, :string, :null => false
  end
end
