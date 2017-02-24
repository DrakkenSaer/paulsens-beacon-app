class CreatePoints < ActiveRecord::Migration[5.0]
  def change
    create_table :points do |t|
      t.belongs_to :pointable, polymorphic: true, index: true
      t.integer :value, default: 0, null: false

      t.timestamps
    end
  end
end
