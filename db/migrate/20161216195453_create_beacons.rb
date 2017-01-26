class CreateBeacons < ActiveRecord::Migration[5.0]
  def change
    create_table :beacons do |t|
      t.uuid :uuid, null: false, unique: true, index: true
      t.string :title, null: false, unique: true
      t.text :description, null: false

      t.timestamps
    end
  end
end
