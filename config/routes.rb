Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_for :users
  root to: "homes#top"
  get "home/about" => "homes#about"
  get "search" => "searches#search"
  
  resources :messages, :only => [:create]
  resources :rooms, :only => [:create, :show, :index]

  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
    resources :book_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
  
  resources :groups do     #ここ！
    get "join" => "groups#join"
  end
  
  resources :users, only: [:index,:show,:edit,:update] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
    get "search", to: "users#search"
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
