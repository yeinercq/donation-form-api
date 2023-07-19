Rails.application.routes.draw do
  devise_for :users
  # get 'pages/home'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "pages#home"
  get "/thanks", to: "pages#thanks"
  get "/campaign", to: "donations#new"

  resources :donations, except: [:show]
  resources :api_tokens, only: [:index, :create, :destroy]

  # GET /api/v1/
  namespace :api do
    namespace :v1 do
      defaults format: :json do
        # Validates api is ok
        get "donaronline/health", to: "donaronline#health"
        get "donaronline/who_i_am", to: "donaronline#who_i_am"
        resources :donations, except: [:new, :edit, :create]
      end
    end
  end
end
