class CreatePeriod < ActiveRecord::Migration[5.0]
  def change
    create_table :matches do |t|
      t.date :date

      t.timestamp
    end
  end
end
