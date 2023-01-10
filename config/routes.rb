# frozen_string_literal: true

Rails.application.routes.draw do
  scope '(:locale)', locale: /#{I18n.available_locales.join('|')}/ do
    devise_for :users

    devise_scope :user do
      get 'sign_in', to: 'devise/sessions#new'
      get 'sign_up', to: 'devise/registrations#new'
      delete 'sign_out', to: 'devise/sessions#destroy'
    end

    get 'static_pages/about'
    get 'static_pages/contacts'
    root to: 'articles#index'

    shallow do
      resources :users, only: %i[show] do
        resources :articles
      end
      resources :articles, only: %i[index] do
        resources :comments
      end
    end
  end
end
