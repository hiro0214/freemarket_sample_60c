Rails.application.routes.draw do
  devise_for :users
  root "items#index"
  resources :items 
  get "detail" => "items#detail"
  get "regi_first" => "items#regi_first"
  get "regi_second" => "items#regi_second"
  get "regi_third" => "items#regi_third"
  get "exhibit" => "items#exhibit"
  get "mypage" => "items#mypage"
end
