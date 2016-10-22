require "rails_helper"

RSpec.describe Api::V1::ShortUrlsController, type: :routing do
  describe "routing" do

    it "routes to api/v1/short_urls#index" do
      expect(:get => "/api/v1/short_urls").to route_to("api/v1/short_urls#index")
    end

    it "routes to api/v1/short_urls#create" do
      expect(:post => "/api/v1/short_urls").to route_to("api/v1/short_urls#create")
    end

    it "routes to api/v1/short_urls#update via PUT" do
      expect(:put => "/api/v1/short_urls/1").to route_to("api/v1/short_urls#update", :id => "1")
    end

    it "routes to api/v1/short_urls#update via PATCH" do
      expect(:patch => "/api/v1/short_urls/1").to route_to("api/v1/short_urls#update", :id => "1")
    end

    it "routes to api/v1/short_urls#destroy" do
      expect(:delete => "/api/v1/short_urls/1").to route_to("api/v1/short_urls#destroy", :id => "1")
    end

    it "routes to api/v1/short_urls#redirect" do
      expect(:get => "/rad3aaf").to route_to("api/v1/short_urls#redirect", :sort_url => "rad3aaf")
    end

  end
end
