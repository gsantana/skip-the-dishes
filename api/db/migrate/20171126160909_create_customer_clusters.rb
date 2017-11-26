class CreateCustomerClusters < ActiveRecord::Migration[5.0]
  def change
    create_table :customer_clusters do |t|
      t.integer :dishes_in_c1
      t.integer :dishes_in_c2
      t.integer :dishes_in_c3
      t.integer :dishes_in_c4
      t.integer :dishes_in_c5
      t.integer :dishes_in_c6
      t.integer :centroid
      t.references :customer, foreign_key: true

      t.timestamps
    end
  end
end
