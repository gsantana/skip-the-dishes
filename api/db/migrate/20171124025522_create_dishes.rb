class CreateDishes < ActiveRecord::Migration[5.0]
  def change
    create_table :dishes do |t|
      t.string :name
      t.float :price
      t.float :calories
      t.references :restaurant, foreign_key: true

      t.timestamps
    end
  end
end
