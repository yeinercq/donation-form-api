Rails.application.routes.draw do
  devise_for :users
  # get 'pages/home'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "pages#home"
  get "/thanks", to: "pages#thanks"

  resources :donations, except: [:show]

  # GET /api/v1/
  namespace :api do
    namespace :v1 do
      defaults format: :json do
        # Validates api is ok
        get "donaronline/health", to: "donaronline#health"
        get "donaronline/index", to: "donaronline#index"
      end
    end
  end
end
