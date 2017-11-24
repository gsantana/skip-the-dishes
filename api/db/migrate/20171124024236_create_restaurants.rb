class CreateRestaurants < ActiveRecord::Migration[5.0]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :contact_name
      t.string :contact_phone
      t.string :email
      t.string :address
      t.datetime :open_at
      t.datetime :close_at
      t.integer :days_of_the_week

      t.timestamps
    end
  end
end
