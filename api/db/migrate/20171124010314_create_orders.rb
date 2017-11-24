class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.datetime :deliver_late
      t.string :status
      t.references :customer, foreign_key: true

      t.timestamps
    end
  end
end
