Rails.application.routes.draw do
  resources :articles do
    resources :quests, only: [:index, :new, :create, :destroy]
    resources :scores, only: [:create, :update]
  end
  resources :makequests
  devise_for :admins, controllers: {
    sessions: 'admins/sessions'
  }
  devise_for :users
  root to:"articles#index"
end
