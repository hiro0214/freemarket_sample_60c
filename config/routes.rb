Rails.application.routes.draw do
  devise_for :users
  root "items#index"
  resources :items do
    get "buy" => "items#buy"
    collection do
      get 'category_children', defaults: { format: 'json' }
      get "category_grandchildren", defaults: { format: "json"}
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

  resources :signup do
    collection do
      get 'step1'
      get 'step2'
      get 'step3'
      get 'step4'
      get 'step5'
      get 'set'
      get 'done'
    end
  end
end

