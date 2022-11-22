Rails.application.routes.draw do
  devise_for :users

  get 'static_pages/about'
  get 'static_pages/contacts'
  root to: 'article#index'
 
  shallow do
    resources :users do
      resource :artciles
    end
    resources :articles do
      resource :comments
    end
  end
end
