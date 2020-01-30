Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'home#index'
  get  "home/about" => 'home#about'
  resources :books
  devise_for :users
  resources :users, only: [:show, :edit, :index, :update]
end
