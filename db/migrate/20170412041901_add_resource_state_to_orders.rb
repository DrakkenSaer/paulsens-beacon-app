class AddResourceStateToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :resource_state, :string
  end
end
