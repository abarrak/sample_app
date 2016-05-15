Rails.application.routes.draw do
  
  get 'users/new'

  # root route & static pages named routing.
  root 'static_pages#home'
  get 'help'    => 'static_pages#help'
  get 'about'   => 'static_pages#about'
  get 'contact' => 'static_pages#contact'

  # users resource routes
  get 'signup'  => 'users#new'

end
