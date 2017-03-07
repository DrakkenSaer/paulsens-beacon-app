class CreateNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :notifications do |t|
      t.string :title, null: false, unique: true
      t.text :description, null: false, unique: true
      t.belongs_to :notifiable, polymorphic: true, index: true

      t.timestamps
    end
  end
end
