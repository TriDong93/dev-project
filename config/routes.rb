Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions' }

  # get 'pages/home'
  root 'pages#index'

  resources :share_videos, path: 'share',  only: [:create] do
    collection do
      get :new
    end
  end
end
