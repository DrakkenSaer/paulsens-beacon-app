class AddColumnsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :phone, :string
    add_column :users, :points, :int, default: 0
    add_column :users, :address, :string
    add_column :users, :visit_count, :int, default: 0
  end
end
