# frozen_string_literal: true

require 'sidekiq-scheduler'

class CustomerClusterizationWorker
  include Sidekiq::Worker

  sidekiq_options :retry => true, :backtrace => true

  def perform(*args)
    generate_dishes_clusters
    generate_customers_clusters
    true
  end

  private

  MAX_NUMBER_OF_CENTROIDS = 6

  def generate_customers_clusters
    count_order_dishes_in_clusters

    number_of_centroids = get_number_of_cluster_with_batter_score(
      customer_dishes_quantity
    )

    generate_clusters(
      customer_dishes_quantity, 
      customer_dishes_quantity_labels, 
      number_of_centroids
    ) do |point, centroid_id|
      customer_cluster = CustomerCluster.find point.label
      customer_cluster.centroid = centroid_id
      customer_cluster.save!
    end
  end

  def count_order_dishes_in_clusters
    Customer.all.each do |customer|
      cluster = if customer.cluster
                  customer.cluster
                else
                  customer.cluster = CustomerCluster.new
                  customer.save
                  customer.cluster
                end

      items = customer.orders.map{ | order | order.items}.flatten

      (1..MAX_NUMBER_OF_CENTROIDS).each do |centroid|
        items_in_cluster = items.select{ | item | item.dish.cluster.centroid == centroid }
        number_of_dishes =  items_in_cluster.inject(0){|sum, i| sum + i.quantity }
        cluster.send "dishes_in_c#{centroid}=", number_of_dishes
      end

      cluster.save
    end
  end

  def generate_dishes_clusters
    number_of_centroids = get_number_of_cluster_with_batter_score(dishes)
    generate_clusters(dishes, dishes_labels, number_of_centroids) do |point, centroid_id|
      dish = Dish.find point.label
      dish_cluster = dish.cluster
      if dish_cluster
        dish_cluster.centroid = centroid_id
        dish_cluster.save!
      else
        dish.cluster = DishCluster.new(centroid: centroid_id)
        dish.save!
      end
    end
  end

  def get_number_of_cluster_with_batter_score(points)
    scores = (2..MAX_NUMBER_OF_CENTROIDS).map { |k| get_clusters_scores(k, points) }

    max_score, index =  scores.take(MAX_NUMBER_OF_CENTROIDS).each_with_index.max
    index + 2
  end

  def get_clusters_scores(k, points)
    kmeans = KMeansClusterer.run k, points, runs: 100
    kmeans.silhouette.round(2)
  end

  def generate_clusters(points, labels, k)
    kmeans = KMeansClusterer.run k, points, labels: labels, runs: 100
    kmeans.clusters.each do |cluster|
      centroid_id = cluster.id + 1
      cluster.points.each do |point|
        yield point, centroid_id
      end
    end
    true
  end

  def dishes
    @dishes ||= Dish.all.map{|d| [d.price, d.calories] }
  end

  def dishes_labels
    @labels ||= Dish.all.map{|d| d.id }
  end

  def customer_dishes_quantity
    @customer_dishes_quantity ||= CustomerCluster.all.map do |c|
      (1..MAX_NUMBER_OF_CENTROIDS).map do |centroid|
        c.send "dishes_in_c#{centroid}"
      end
    end
  end

  def customer_dishes_quantity_labels
    @customer_dishes_quantity_labels ||= CustomerCluster.all.map{|d| d.id }
  end
end
