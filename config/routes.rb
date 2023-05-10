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
  get 'about', to: 'public/homes#about'

  get '/users' => "public/users#show"

  scope module: :public do
    resources :posts, only: [:new, :show, :index, :create, :edit, :update, :destroy] do
      resource :likes, only: [:create, :destroy]
      resources :comments, only: [:create]
      get :search, on: :collection
      post :search, on: :collection
    end
  end



  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    resources :users, only: [:index, :show, :edit, :update]
    end

     # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  end


