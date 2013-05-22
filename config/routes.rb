Stripe2::Application.routes.draw do
  get 'admin' => "admin#index"

  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end

  resources :users

  resources :workspaces

  match '/diff' => 'workspaces#diff'

  root :to => 'home#index', :as => 'home'
  get "home/index"
end