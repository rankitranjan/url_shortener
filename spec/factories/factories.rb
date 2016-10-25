require 'factory_girl'

FactoryGirl.define do

  factory :user do
    email  "test@gmail.com"
    password "123123123"
    confirm_password "123123123"
    auth_token "PAq9JKKGPzFvhkJ_3u1ifJUjXyrtBjWSaw"
  end

  factory :short_url do
  	original_url "http://www.google.com/12s"
  	shorty "asd31A"
  end

  factory :short_visit do
    visitor_ip "12.22.11.1"
    visitor_city "Bangalore"
    visitor_state "Karnataka"
  end

end