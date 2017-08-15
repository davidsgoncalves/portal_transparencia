class AddDescriptionToPayment < ActiveRecord::Migration[5.0]
  def change
    add_column :payments, :description, :string
  end
end
