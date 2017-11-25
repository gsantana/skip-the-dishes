module Helpers
  def json
    JSON.parse(response.body)
  end

  def jsonapi_headers
    {
      'CONTENT-TYPE' => 'application/vnd.api+json',
      'ACCEPT' => 'application/vnd.api+json'
    }
  end
end
