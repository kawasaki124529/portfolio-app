Rails.application.routes.draw do
  # namespaceを利用することで、 /api/each_api 形式のrouting設定を行う
  namespace :api, { format: 'json' } do
    mount_devise_token_auth_for 'User', at: 'auth', controllers: {
      registrations: 'api/auth/registrations'
    }
    resources :topics, only: [:new, :create, :index]
    resources :likes, only: [:index, :create]
    delete '/likes', to: 'likes#destroy'
  end  
end
