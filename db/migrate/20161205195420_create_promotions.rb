class CreatePromotions < ActiveRecord::Migration[5.0]
  def change
    create_table :promotions do |t|
      t.belongs_to :promotional, polymorphic: true, index: true
      t.string :title, null: false
      t.text :description, null: false
      t.string :code, null: false
      t.integer :redeem_count, default: 0, null: false
      t.boolean :daily_deal, default: false, null: false
      t.boolean :featured, default: false, null: false
      t.float :cost, default: 0, null: false
      t.datetime :expiration

      t.timestamps
    end
  end
end
