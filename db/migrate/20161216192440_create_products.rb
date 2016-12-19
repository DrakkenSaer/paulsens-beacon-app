class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.boolean :featured, default: false, null: false
      t.string :cost, default: 0, null: false
      t.string :title, null: false
      t.text :description, null: false

      t.timestamps
    end
  end
end
