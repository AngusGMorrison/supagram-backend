Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post "/sign_in", to: "users#sign_in", as: "sign_in"
  post "/signup", to: "users#signup", as: "signup"
end
