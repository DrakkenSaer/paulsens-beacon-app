class AddUuidColsToBeacons < ActiveRecord::Migration[5.0]
  def change
    add_column :beacons, :major_uuid, :string, unique: true, index: true
    add_column :beacons, :minor_uuid, :string, unique: true, index: true
    
    Beacon.all.each do |beacon|
      beacon.set_default_extra_uuids
      beacon.save!
    end
    
    change_column :beacons, :major_uuid, :string, :null => false
    change_column :beacons, :minor_uuid, :string, :null => false
  end
end
