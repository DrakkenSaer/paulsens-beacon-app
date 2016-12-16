class CreateBeacons < ActiveRecord::Migration[5.0]
  def change
    create_table :beacons do |t|
      t.uuid :uuid, default: 'uuid_generate_v4()', null: false
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
