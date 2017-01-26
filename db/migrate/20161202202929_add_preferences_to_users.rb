class AddPreferencesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :preferences, :text
    add_index :users, :preferences
  end
end