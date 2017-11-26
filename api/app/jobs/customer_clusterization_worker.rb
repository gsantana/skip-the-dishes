# frozen_string_literal: true

class CustomerClusterizationWorker
  include Sidekiq::Worker

  sidekiq_options :retry => true, :backtrace => true

  def perform(*args)
    data = Dish.all.map{|d| [d.price, d.calories] }
    labels = Dish.all.map{|d| d.name }
    k = 6
    kmeans = KMeansClusterer.run k, data, labels: labels, runs: 5
    kmeans.clusters.each do |cluster|
      puts  cluster.id.to_s + '. ' + 
        cluster.points.map(&:label).join(", ") + "\t" +
        cluster.centroid.to_s
    end
  end
end
