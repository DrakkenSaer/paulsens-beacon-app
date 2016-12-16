class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.boolean :featured, default: false, null: false
      t.string :cost
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
