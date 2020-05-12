Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: "pages#home"
  
  resources :trips
  resources :drivers
  resources :passengers do
    resources :trips, only: [:index, :create]
  end

end
