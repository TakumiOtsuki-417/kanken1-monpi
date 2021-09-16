Rails.application.routes.draw do
  get 'helps/welcome'
  resources :articles do
    resources :quests, only: [:index, :new, :create, :destroy]
    resources :scores, only: [:create, :update]
  end
  resources :makequests
  devise_for :admins, controllers: {
    registrations: 'admins/registrations'
  }
  devise_for :users
  root to:"articles#index"
end
