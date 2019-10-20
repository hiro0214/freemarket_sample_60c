Rails.application.routes.draw do
  devise_for :users
  root "items#index"
  resources :items do
    get "buy" => "items#buy"
    collection do
      get 'get_category_children', defaults: { format: 'json' }
    end
  end

  get "new_after" => "items#new_after"

  get "mypage" => "items#mypage"
  get "logout" => "items#logout"
  get "profile" => "items#profile"

  get "more" => "items#more"
  get "buy_after" => "items#buy_after"

  resources :users do
    get "edit_item/:id" => "users#edit_item" 
    get "logout" => "users#logout"
    get "profile" => "users#profile"
    get "exhibiting" => "users#exhibiting"
    get "identification" => "users#identification"
    get "delete_after" => "users#delete_after"
  end

  resources :signup do
    collection do
      get 'step1'
      get 'step2'
      # get 'step3'
      # get 'step4'
      # get 'step5'
      get 'done'
    end
  end
end

