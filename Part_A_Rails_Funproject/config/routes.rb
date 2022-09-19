Rails.application.routes.draw do
  resources :products
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  post '/', to: 'products#landing_page'

  # Defines the root path route ("/")
  root "products#landing_page"
end
