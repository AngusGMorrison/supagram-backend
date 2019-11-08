Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post "/sign-in", to: "users#sign_in", as: "sign_in"
  post "/sign-up", to: "users#sign_up", as: "sign_up"
end
