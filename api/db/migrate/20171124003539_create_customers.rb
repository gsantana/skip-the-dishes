class CreateCustomers < ActiveRecord::Migration[5.0]
  def change
    create_table :customers do |t|
      t.string :first_name
      t.string :last_name
      t.string :address
      t.string :email

      t.timestamps
    end
    add_index :customers, :first_name
    add_index :customers, :last_name
  end
end
