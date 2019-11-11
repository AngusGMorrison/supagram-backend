Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post "/sign-in", to: "users#sign_in", as: "sign_in"
  post "/sign-up", to: "users#sign_up", as: "sign_up"

  post "/posts", to: "posts#create", as: "create_post"
  post "/posts/:id", to: "posts#like", as: "like_post"

end
