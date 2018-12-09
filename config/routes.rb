Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'home_show/:id', to: 'home#show', as: 'home_show'
  resources :teams
  resources :users
  resource :sessions, only: [:new, :create, :destroy]


  root({ to: 'home#index' })
  patch 'update_user_followed_teams', to: "teams#update_user_followed_teams"
end
