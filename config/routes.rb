Rails.application.routes.draw do

  get "/:sort_url" => "api/v1/short_urls#redirect"

  namespace :api do
    namespace :v1 do
  	  post "users/registration" => 'users#registration'
  	  post "users/login" => 'users#login'
  	  delete "users/logout" => 'users#logout'
      resources :short_urls
    end
  end
end
