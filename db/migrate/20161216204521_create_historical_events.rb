class CreateHistoricalEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :historical_events do |t|
      t.string :title, null: false, unique: true
      t.text :description, null: false, unique: true
      t.date :date, null: false, unique: true

      t.timestamps
    end
  end
end
