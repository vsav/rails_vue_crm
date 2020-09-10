Rails.application.routes.draw do
  devise_for :clients, path: :clients
  devise_for :staffs, path: :staffs

  root 'application#index'
end
