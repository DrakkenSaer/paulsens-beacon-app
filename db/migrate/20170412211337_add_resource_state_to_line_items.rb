class AddResourceStateToLineItems < ActiveRecord::Migration
  def change
    add_column :line_items, :resource_state, :string
  end
end
