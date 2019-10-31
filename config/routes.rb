Rails.application.routes.draw do

  devise_for :users,
  controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  root "items#index"

  resources :signup do
    collection do
      get 'step1'
      get 'step2'
      post 'step2'
      get 'step3'
      post 'step3'
      get 'step4'
      get "/jip" => "signup#jip"
      post 'create_step4' => "signup#create_step4"
      get 'step5'
      get 'set'
      get 'done'
    end
  end

  resources :items do
    resources :good, only: [:create, :destroy]
    get "buy" => "items#buy"
    collection do
      get 'category_children', defaults: { format: 'json' }
      get "category_grandchildren", defaults: { format: "json"}
      get "search"
      get "search_more"
      # post 'items/:id' => 'items#pay', as: :pay#Pay.jp
    end
  end

  resources :items ,only: [:edit] do
    member do
      get 'category_children', defaults: { format: 'json' }
      get "category_grandchildren", defaults: { format: "json"}
    end
    patch "edit_update" => "items#edit_update"
  end

  get "new_after" => "items#new_after"

  get "mypage" => "items#mypage"
  get "logout" => "items#logout"
  get "profile" => "items#profile"

  get "more/:id" => "items#more"
  get "buy_after" => "items#buy_after"

  resources :users do
    get "edit_item/:id" => "users#edit_item"
    get "logout" => "users#logout"
    get "profile" => "users#profile"
    get "exhibiting" => "users#exhibiting"
    get "identification" => "users#identification"
    get "delete_after" => "users#delete_after"
    get "trade/:id" => "users#trade"
    get "trade_after" => "users#trade_after"
    get "sold/:id" => "users#sold"
  end

  resources :credit_cards do
    collection do
      post 'show', to: 'credit_cards#show'
      post 'pay', to: 'credit_cards#pay'
      post 'delete', to: 'credit_cards#delete'
    end
  end

  resources :purchase, only: [:index] do
    collection do
      get 'index', to: 'purchase#index'
      post 'pay', to: 'purchase#pay'
      get 'done', to: 'purchase#done'
    end
  end

  get 'purchase/index'
  get 'purchase/done'

end