Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/services', to: 'services#index'
  post '/services', to: 'services#create'
  get '/appointments', to: 'appointments#index'
  post '/appointments', to: 'appointments#create'
  get '/service_providers', to: 'service_providers#index'
  patch '/service_providers/:id', to: 'service_providers#update'
end
