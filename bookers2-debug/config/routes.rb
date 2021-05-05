Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  get 'home/about' => 'homes#about'
  resources :users, only: [:index, :show, :create, :edit, :update] do
       member do 
        get :followings, :followers
      end
  end
  post 'follow/:id' => 'relationships#follow', as: 'follow' 
  post 'unfollow/:id' => 'relationships#unfollow', as: 'unfollow'
  get "search" => "searches#search"
  resources :books, only: [:create, :index, :show, :edit, :update, :destroy] do
  resource :favorites, only: [:create, :destroy]
  resources :book_comments, only: [:create, :destroy]
  end
end