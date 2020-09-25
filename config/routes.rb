Rails.application.routes.draw do
  devise_for :clients, skip: :registrations
  devise_for :staffs, skip: :registrations

  root to: 'application#index'

  namespace :clients do
    root to: "home#index"
  end

  namespace :staffs do
    root to: "home#index"
    get "/profile", to: "home#profile"
    get "/clients_list", to: "home#clients_list"
    post "/create_client", to: "home#create_client"
  end

  namespace :api do
    namespace :v1 do
      post 'auth', to: 'api_token#create'
      namespace :clients do
        resources :home, only: :show
      end
      namespace :staffs do
        resources :home, only: :show
      end
    end
  end
end
