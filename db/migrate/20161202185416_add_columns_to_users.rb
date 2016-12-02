class AddColumnsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :phone, :string
    add_column :users, :points, :int
    add_column :users, :address, :string
    add_column :users, :visit_count, :int
  end
end
