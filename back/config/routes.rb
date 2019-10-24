Rails.application.routes.draw do

  namespace :api do
    mount_devise_token_auth_for 'User', at: 'auth', controllers: {
      registrations: 'api/auth/registrations'
    }
  end  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
