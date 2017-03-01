class AddColumnsToNotifications < ActiveRecord::Migration[5.0]
  def change
    add_column :notifications, :entry_message, :string
    add_column :notifications, :exit_message, :string
  end
end
