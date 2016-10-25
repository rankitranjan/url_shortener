require 'rails_helper'

RSpec.describe ShortUrl, type: :model do

  let(:short_url) { FactoryGirl.build(:short_url) }

  it { should belong_to(:user) }
  it { should have_many(:short_visits) }

  it "is valid with valid attributes" do
    expect(build(:short_url)).to be_valid
  end

  it "is not valid without an original_url" do
    shortUrl = ShortUrl.new(original_url: nil)
    expect(shortUrl).to_not be_valid
  end

  it "is valid with an original_url" do
    shortUrl = ShortUrl.new(original_url: "https://www.google.com/")
    expect(shortUrl).to be_valid
  end

  it "is not valid without a user_id" do
    shortUrl = ShortUrl.new(user_id: nil)
    expect(shortUrl).to_not be_valid
  end

  it "is valid with a user_id and an original_url" do
    user = FactoryGirl.create(:user)
    shortUrl = ShortUrl.new(original_url: "https://www.google.com/", user_id: user.id)
    expect(shortUrl).to be_valid
  end

  it "is not valid with duplicate original_url" do
    older_short_url = FactoryGirl.create(:short_url)
    short_url.original_url = older_short_url.original_url
    expect(short_url).to_not be_valid
  end

   it "is not valid with duplicate original_url" do
    older_short_url = FactoryGirl.create(:short_url)
    short_url.original_url = older_short_url.original_url
    expect(short_url).to_not be_valid
  end
end
