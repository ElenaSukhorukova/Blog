Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do  
    get 'sign_in', to: 'devise/sessions#new'
    get 'sign_up', to: 'devise/registrations#new'
    get 'sign_out', to: 'devise/sessions#destroy'
  end

  get 'static_pages/about'
  get 'static_pages/contacts'
  root to: 'articles#index'
 
  shallow do
    resources :users do
      resources :articles
    end
    resources :articles do
      resources :comments
    end
  end

  resources :articles, only: %i[index]
end
