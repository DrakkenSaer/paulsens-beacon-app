class AddUuidColsToBeacons < ActiveRecord::Migration[5.0]
  def change
    add_column :beacons, :major_uuid, :string, unique: true, index: true, null: false
    add_column :beacons, :minor_uuid, :string, unique: true, index: true, null: false
  end
end
