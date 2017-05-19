class AddResourceStateToRewards < ActiveRecord::Migration
  def change
    add_column :rewards, :resource_state, :string
  end
end
