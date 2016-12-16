class CreateLineItems < ActiveRecord::Migration[5.0]
  def change
    create_table :line_items do |t|
      t.belongs_to :order, foreign_key: true
      t.belongs_to :orderable, polymorphic: true, index: true, null: false
      t.string :item_cost

      t.timestamps
    end
  end
end
