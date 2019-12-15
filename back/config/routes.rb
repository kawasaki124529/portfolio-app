Rails.application.routes.draw do
  # namespaceを利用することで、 /api/each_api 形式のrouting設定を行う
  namespace :api, { format: 'json' } do
    mount_devise_token_auth_for 'User', at: 'auth', controllers: {
      registrations: 'api/auth/registrations'
    }
    resources :topics, only: [:create, :index,]
    resources :likes, only: [:index, :create]
    resources :comments, only: [:index, :create]
    delete '/likes', to: 'likes#destroy'
    delete '/topics', to: 'topics#destroy'
    get '/topics/like', to: 'topics#likes'  
    get '/topics/mytopic', to: 'topics#my_topics'
  end  
end
