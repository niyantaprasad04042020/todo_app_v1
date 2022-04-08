Rails.application.routes.draw do
  resource :users, only: [:create]
  post "/signup", to: "users#signup"
  post "/login", to: "users#login"
  get "/auto_login", to: "users#auto_login"
end
