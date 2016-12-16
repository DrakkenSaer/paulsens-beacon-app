class CreateHistoricalEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :historical_events do |t|
      t.string :title
      t.text :description
      t.date :date

      t.timestamps
    end
  end
end
