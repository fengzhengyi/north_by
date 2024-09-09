Rails.application.routes.draw do
  resources :favorites
  resources :shopping_carts
  resources :ticket_orders
  resources :tickets
  resources :gigs
  resources :concerts
  resources :bands
  resources :venues
  resources :seats, only: %i[update destroy]
  resource :clear_all_tickets, only: :destroy
  resource :tickets_to_buy_count, only: :update
  resource :sold_out_concerts, only: :show
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root to: "schedules#show"
end
