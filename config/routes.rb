Rails.application.routes.draw do
  get '/item/hashtag/:name', to: "items#hashtag"
  get 'cards/new'
  get 'users/show'
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'
  }
  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
  end
  resources :users, only: [:show, :update,:edit]
  resources :cards, only: [:new, :create]
  resources :profiles, only: [:new, :create]
  root "items#index"
  resources :items do
    resources :comments, only: [:create,:destroy]
    resources :orders, only:[:index,:create]
    post 'order', on: :member
    collection do
    get 'search'
    end
    collection do
    get 'item_search'
    end
  end
end