Rails.application.routes.draw do
  namespace :public do
    get 'users/show'
    get 'users/edit'
    get 'users/unsubscribe'
  end
  namespace :public do
    get 'homes/top'
    get 'homes/about'
  end
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

  scope module: :public do
    resources :posts, only: [:new, :index, :create, :edit, :update, :destroy]
  end

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }


    # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
