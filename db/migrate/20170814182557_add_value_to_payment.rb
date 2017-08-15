class AddValueToPayment < ActiveRecord::Migration[5.0]
  def change
    add_column :payments, :value, :decimal, precision: 8, scale: 2
  end
end
