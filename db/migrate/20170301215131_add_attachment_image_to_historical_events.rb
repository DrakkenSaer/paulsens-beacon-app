class AddAttachmentImageToHistoricalEvents < ActiveRecord::Migration
  def self.up
    change_table :historical_events do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :historical_events, :image
  end
end
