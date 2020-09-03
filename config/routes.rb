Rails.application.routes.draw do
  get 'cards/new'
  get 'users/show'
  devise_for :users
  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
  end
  resources :users, only: [:show, :update]
  resources :cards, only: [:new, :create]
  root "items#index"
  resources :items do
    resources :orders, only:[:index,:create]
    post 'order', on: :member
    collection do
    get 'search'
    end
  end
end