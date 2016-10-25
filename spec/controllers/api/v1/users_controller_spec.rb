require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do

  let(:valid_attributes) {
    user = FactoryGirl.create(:user)
    {email: 'http://api.rubyonrails.org', password: '123123123', confirm_password: '123123123'}
  }

  let(:invalid_attributes) {
    {emaiql: 'http://api.rubyonrails.org', passwqord: '123123123', confirm_passwoqrd: '123123123'}
  }

  describe "GET 'index' " do
    it "returns a successful 200 response" do
      get :index, format: :json
      expect(response).to have_http_status(200)
    end
  end

  context "with valid params" do
    it "registration for a new User" do
      expect {
         short_url = User.new(valid_attributes)
      }.to change(User, :count).by(1)
    end

    it "login for an User" do
      short_url = User.new(email: "rankit4u@gmail.com", password: "123123123")
      expect(response).to have_http_status(200)
    end
  end

  context "with invalid attributes" do

    it "does not register for a new User" do
      short_url = User.new({email: 'http://api.rubyonrails.org', password: '123123123', confirm_password: '123123'})
      expect(assigns(:user)).not_to be_a_new(User)
    end

    it "does not login if invalid User" do
      short_url = User.new(email: "ranit4u@gmail.com", password: "123123123")
      expect(response).to have_http_status(401)
    end
  end
end
