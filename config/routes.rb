Rails.application.routes.draw do
  use_doorkeeper

   namespace :api do
    namespace :v1 do
      get '/users/me', to: 'users#me'
      resources :users
      resources :questions
      resources :tags, only: [:index, :show]
      resources :answers, only: [:index, :create, :update, :destroy]
    end
  end
end
