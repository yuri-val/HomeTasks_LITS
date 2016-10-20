Rails.application.routes.draw do

  resources :tags
  resources :twits, shallow: true do
    resources :comments
  end
  resources :users, shallow: true do
    resources :twits
    resources :comments
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'twits#index'
end
