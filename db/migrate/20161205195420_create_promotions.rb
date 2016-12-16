class CreatePromotions < ActiveRecord::Migration[5.0]
  def change
    create_table :promotions do |t|
      t.belongs_to :promotional, polymorphic: true, index: true
      t.string :title
      t.text :description
      t.string :code
      t.integer :redeem_count, default: 0
      t.boolean :daily_deal, default: false
      t.boolean :featured, default: false
      t.integer :cost
      t.datetime :expiration

      t.timestamps
    end
  end
end
