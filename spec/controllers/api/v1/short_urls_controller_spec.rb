require 'rails_helper'

RSpec.describe Api::V1::ShortUrlsController, type: :controller do

  let(:valid_attributes) {
    short_url = FactoryGirl.create(:short_url)
    user = FactoryGirl.create(:user)
    { original_url: 'http://api.rubyonrails.org', shorty: '1seEfs1', user_id: user.id }
  }

  let(:invalid_attributes) {
    short_url = FactoryGirl.create(:short_url)
    user = FactoryGirl.create(:user)
    {original_ul: 'http://api.rubyonrails.org', shoty: '1seEfs1', userid: user.id}
  }

  context 'with valid attributes' do
    it 'creates the short_url' do
     expect {
          post :create, params: {short_url: valid_attributes, format: :json}
        }.to change(ShortUrl, :count).by(1)
    end
    it "responds with 200" do
      short_url = ShortUrl.new(valid_attributes)
      expect(response).to have_http_status(200)
    end
  end

  context 'with invalid attributes' do
    it "does not create the short_url" do
        post :create, params: {short_url: invalid_attributes, format: :json}
        expect(assigns(:short_url)).not_to be_a_new(ShortUrl)
      end

    it 'responds with 401' do
      post :create, params: {short_url: invalid_attributes, format: :json}
      expect(response).to have_http_status(401)
    end
  end
end
