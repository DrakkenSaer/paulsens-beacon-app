class AddAttachmentImageToPromotions < ActiveRecord::Migration
  def self.up
    change_table :promotions do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :promotions, :image
  end
end
