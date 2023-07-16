Rails.application.routes.draw do

# 顧客用
# URL /users/sign_in ...
  devise_for :users, controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions',
    passwords: 'public/passwords'
  }

  devise_scope :user do
    post 'public/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end

  root to: 'public/homes#top'
  get '/users' => "public/users#show"
  get '/users/information/edit' => "public/users#edit"
  patch '/users/information' => "public/users#update"
  get '/users/favorites' => "public/users#favorite"
  get '/users/unsubscribe' => 'public/users#unsubscribe'
  patch '/users/withdraw' => 'public/users#withdraw'

  resources :users do
    member do
      get :likes
    end
  end

  scope module: :public do
    resources :posts, only: [:new, :show, :index, :create, :edit, :update, :destroy] do
      get :search, on: :collection
      post :search, on: :collection
      resources :likes, only: [:create, :destroy]
      resources :comments, only: [:create]
    end
  end



  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:passwords] ,controllers: {
    registrations: "admin/registrations",
    sessions: "admin/sessions"
  }

  namespace :admin do
    get '/' => "homes#top"
    resources :users, only: [:index, :show, :edit, :update]
    resources :posts, only: [:index, :show, :edit, :update, :destroy] do
      resources :tags, only: [:update]
    end
    resources :comments, only: [:edit, :destroy]
  end



     # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  end


