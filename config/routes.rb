Rails.application.routes.draw do
  devise_for :clients, skip: :registrations
  devise_for :staffs, skip: :registrations

  root to: 'application#index'

  namespace :clients do
    root to: "home#index"
  end

  namespace :staffs do
    root to: "home#index"
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
