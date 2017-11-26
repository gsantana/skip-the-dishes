class CreateDishClusters < ActiveRecord::Migration[5.0]
  def change
    create_table :dish_clusters do |t|
      t.integer :centroid
      t.references :dish, foreign_key: true

      t.timestamps
    end
  end
end
