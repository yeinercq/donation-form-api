Rails.application.routes.draw do
  devise_for :users
  # get 'pages/home'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "pages#home"

  namespace :api do
    namespace :v1 do
      defaults format: :json do
        get "donaronline/health", to: "donaronline#health"
      end
    end
  end
end
