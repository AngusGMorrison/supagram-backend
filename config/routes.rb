Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post "/sign-in", to: "users#sign_in"
  post "/sign-up", to: "users#sign_up"

  post "/posts", to: "posts#create"
  post "/posts/:post_id", to: "posts#like"
  delete "/posts/:post_id", to: "posts#unlike"

  post "/follow", to: "follows#create"

end
