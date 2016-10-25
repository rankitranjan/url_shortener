require 'rails_helper'

RSpec.describe User, type: :model do

  let(:user) { FactoryGirl.build(:user) }

  it { should have_many(:short_urls) }

  it "is valid with valid attributes" do
    expect(build(:user)).to be_valid
  end

  it "is not valid without an email" do
    user = User.new(email: nil)
    expect(user).to_not be_valid
  end

  it "is not valid without password" do
    user = User.new(password: nil)
    expect(user).to_not be_valid
  end

  it "is not valid without confirm_password" do
    user = User.new(confirm_password: nil)
    expect(user).to_not be_valid
  end

  it "is not valid with duplicate email" do
    older_user = FactoryGirl.create(:user)
    user.email = older_user.email
    expect(user).to_not be_valid
  end

  it "is valid with email password and confirm_password" do
    user = User.new(email: "test@test.com", password: "password", confirm_password: "password")
    expect(user).to be_valid
  end
end
