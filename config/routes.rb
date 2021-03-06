Rails.application.routes.draw do
  resources :surveys do
    member do
      post 'submission'
      post 'invite'
      post 'results'
      post 'questions'
    end
  end
  devise_for :users
  root to: 'surveys#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
