Rails.application.routes.draw do
  devise_for :users
  root "items#index"
  resources :items 
  get "detail" => "items#detail"
  get "regi_first" => "items#regi_first"
  get "regi_second" => "items#regi_second"
  get "regi_third" => "items#regi_third"
  get "regi_fourth" => "items#regi_fourth"
  get "regi_fifth" => "items#regi_fifth"
  get "exhibit" => "items#exhibit"
  get "mypage" => "items#mypage"
  get "logout" => "items#logout"
  get "profile" => "items#profile"
end
