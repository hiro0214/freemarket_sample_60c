Rails.application.routes.draw do
  devise_for :users
  root "items#index"
  resources :items 
  get "detail" => "items#detail"
  get "mypage" => "items#mypage"
end
