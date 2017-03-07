class CreateCurrencies < ActiveRecord::Migration[5.0]
  def change
    create_table :currencies do |t|
      t.belongs_to :cashable, polymorphic: true, index: true
      t.string :type
      t.integer :value

      t.timestamps
    end
  end
end
