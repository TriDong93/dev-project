Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions' }

  # get 'pages/home'
  root 'pages#index'
end
