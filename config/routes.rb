Rails.application.routes.draw do
  resources :ongoing_quests
  resources :quests
  resources :admins
  resources :users do
    resources :events
  end
  resources :users do
    resources :skills
  end
  #resources :events
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  #get "/login" => "sessions#new", as: "login"
  post "/login" => "sessions#create"
  delete "/logout" => "sessions#destroy", as: "logout"

  # You can have the root of your site routed with "root"
  post "oauth/callback" => "oauths#callback"
  get "oauth/callback" => "oauths#callback" # for use with Github
  get "oauth/:provider" => "oauths#oauth", as: :auth_at_provider
  delete "oauth/:provider" => "oauths#destroy", as: :delete_oauth
  root "statics#index"
end
