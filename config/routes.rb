Rails.application.routes.draw do
  root "users#index"

  resources :users do
    get :employer_details, on: :member
  end

  resources :employments, only: [:new, :create]

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
