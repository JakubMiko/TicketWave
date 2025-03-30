Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions"
  }

  devise_for :admins, controllers: {
    registrations: "admins/registrations",
    sessions: "admins/sessions"
  }, path: "admins", class_name: "User"

  namespace :users do
    get "dashboard", to: "dashboard#show", as: :dashboard
  end

  namespace :admins do
    get "dashboard", to: "dashboard#show", as: :dashboard
  end

  resources :events
  root to: "landing#show"
  get "up" => "rails/health#show", as: :rails_health_check
end
