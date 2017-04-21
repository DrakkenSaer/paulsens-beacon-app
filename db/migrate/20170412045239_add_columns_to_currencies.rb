class AddColumnsToCurrencies < ActiveRecord::Migration[5.0]
  def change
    add_column :currencies, :last_transmutation_amount, :float
    add_column :currencies, :last_transmutation_date, :datetime
  end
end
