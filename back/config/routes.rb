Rails.application.routes.draw do
  # namespaceを利用することで、 /api/each_api 形式のrouting設定を行う
  namespace :api do
    mount_devise_token_auth_for 'User', at: 'auth', controllers: {
      registrations: 'api/auth/registrations'
    }
    resources :topics, only: %i(new create)
  end  
end
