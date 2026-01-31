Rails.application.routes.draw do
  post "login", to: "authentication#login"
  get "products/index"

  get "up" => "rails/health#show", as: :rails_health_check
end
