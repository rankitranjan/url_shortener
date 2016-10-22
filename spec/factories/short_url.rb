require 'factory_girl'

FactoryGirl.define do

  factory :user do
    email "John@gmmaq.com"
    password "123123123"
    confirm_password "123123123"
    auth_token "123123123123123"
  end
end