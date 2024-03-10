Rails.application.routes.draw do
  devise_for :users
  root to: "prototypes#index"
  resources :prototypes
  resources :users, only:  :show
  get 'users/:id', to: 'users#show', as: :show_user # ユーザーの詳細ページに対するルーティングを追加
  resources :prototypes do
    resources :comments, only: :create
  end
end