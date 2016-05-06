Rails.application.routes.draw do
  # static pages routing
  root 'static_pages#home'
  get 'static_pages/help'
  get 'static_pages/about'
end
