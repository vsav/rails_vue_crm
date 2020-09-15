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
end
