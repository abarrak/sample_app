Rails.application.routes.draw do

  get 'password_resets/new'

  get 'password_resets/edit'

  # root route 
  root 'static_pages#home'
  # static pages named routing.
  get 'help'    => 'static_pages#help'
  get 'about'   => 'static_pages#about'
  get 'contact' => 'static_pages#contact'

  # users resource routes
  resources :users
  get 'signup' => 'users#new'

  # sessions name routes
  get     'login'  => 'sessions#new'
  post    'login'  => 'sessions#create'
  delete  'logout' => 'sessions#destroy'

  # account activations routes
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]

  # microposts routes
  resources :microposts, only: [:create, :destroy]
end
