class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.string :type, null: false
      t.boolean :featured, default: false, null: false
      t.float :cost, default: 0, null: false
      t.string :title, null: false
      t.text :description, null: false
      t.attachment :image

      t.timestamps
    end
  end
end
