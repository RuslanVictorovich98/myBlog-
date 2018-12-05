Rails.application.routes.draw do
  # get 'sessions/new'
  root 'posts#index', as: 'home'
  get 'about' => 'pages#about', as: 'about'
  get 'users/new'	
  
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  
  
  resources :posts do
    resources :comments
  end
  resources :users
end
