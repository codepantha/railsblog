Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
get "/users", to: "users#index"
get "/users/:id", to: "users#show"

  # Defines the root path route ("/")
  root "blog_entries#index"
end
