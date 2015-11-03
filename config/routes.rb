Rails.application.routes.draw do

  devise_for :users
  root to: 'messages#index'
  resources :messages
  resources :users do
    resources :contacts
  end
  resources :inbound_messages

end
