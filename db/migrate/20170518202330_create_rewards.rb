class CreateRewards < ActiveRecord::Migration[5.0]
  def change
    create_table :rewards do |t|
      t.belongs_to :user, foreign_key: true, null: false
      t.belongs_to :rewardable, polymorphic: true, index: true, null: false
      t.datetime :redeemed_date

      t.timestamps
    end
  end
end
