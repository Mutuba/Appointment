# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    sessions: 'users/sessions'
  }

  root 'users#index'
  resources :events
  resources :bookings
  resources :users, except: %i[destroy create]

  get 'dashboard', to: 'dashboard#index'
end
