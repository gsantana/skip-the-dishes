class Dish < JsonApiClient::Resource
  self.site = ENV.fetch('API_URL', 'http://localhost:3000')

  belongs_to :restaurant

end
