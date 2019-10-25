Rails.application.routes.draw do
  get 'purchase/index'
  get 'purchase/done'
  devise_for :users
  root "items#index"
  resources :items do
    get "buy" => "items#buy"
    collection do
      get 'category_children', defaults: { format: 'json' }
      get "category_grandchildren", defaults: { format: "json"}

      # post 'items/:id' => 'items#pay', as: :pay#Pay.jp
    end
  end

  get "new_after" => "items#new_after"

  get "mypage" => "items#mypage"
  get "logout" => "items#logout"
  get "profile" => "items#profile"

  get "more" => "items#more"
  get "buy_after" => "items#buy_after"

  resources :users do
  get "logout" => "users#logout"
  get "profile" => "users#profile"
  get "exhibiting" => "users#exhibiting"
  get "identification" => "users#identification"
  end

  resources :signup do
    collection do
      get 'step1'
      get 'step2'
      get 'step3'
      # get 'step4'
      # get 'step5'
      get 'done'
    end
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


end