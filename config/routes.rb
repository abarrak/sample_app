Rails.application.routes.draw do
  
  # root route 
  root 'static_pages#home'
  # static pages named routing.
  get 'help'    => 'static_pages#help'
  get 'about'   => 'static_pages#about'
  get 'contact' => 'static_pages#contact'

  # users resource routes
  resources :users
  get 'signup' => 'users#new'

end
