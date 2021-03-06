class CreateLineItems < ActiveRecord::Migration[5.0]
  def change
    create_table :line_items do |t|
      t.belongs_to :lineable, polymorphic: true, index: true, null: false
      t.belongs_to :order, foreign_key: true, index: true, null: false
      t.float :item_cost, null: false

      t.timestamps
    end
  end
end
