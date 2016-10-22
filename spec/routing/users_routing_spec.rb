require "rails_helper"

RSpec.describe Api::V1::UsersController, type: :routing do
  describe "routing" do

    it "routes to api/v1/users#registration" do
      expect(:post => "/api/v1/users/registration").to route_to("api/v1/users#registration")
    end

    it "routes to api/v1/users#login" do
      expect(:post => "/api/v1/users/login").to route_to("api/v1/users#login")
    end

    it "routes to api/v1/users#logout" do
      expect(:delete => "/api/v1/users/logout").to route_to("api/v1/users#logout")
    end
  end
end
