require 'rails_helper'

RSpec.describe "Dishes", type: :request do
  describe "GET /dishes" do
    it "works! (now write some real specs)" do
      get dishes_path
      expect(response).to have_http_status(200)
    end
  end
end
