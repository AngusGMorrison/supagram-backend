Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post "/sign-in", to: "users#sign_in"
  post "/sign-up", to: "users#sign_up"
  get "/users/:username", to: "users#show"
  put "/users/:username/avatar", to: "users#change_avatar"

  get "/posts", to: "posts#show_feed"
  post "/posts", to: "posts#create"
  post "/posts/:post_id", to: "posts#like"
  delete "/posts/:post_id", to: "posts#unlike"

  post "/follow", to: "follows#create"
  delete "/follow", to: "follows#destroy"

end
