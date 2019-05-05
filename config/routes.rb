Rails.application.routes.draw do

  root 'pages#home'

  devise_for :users, 
  			 :path => '', 
  			 :path_names => {:sign_in => 'login', :sign_out => 'logout', :edit => 'profile'},
  			 :controllers => {:omniauth_callbacks => 'omniauth_callbacks',
  			 				  :registrations => 'registrations'
  			 				 }

  resources :users, only: [:show, :destroy, :edit, :create]	
  resources :rooms
  resources :photos

  resources :room do
    resources :reservations, only: [:create, :destroy]
  end		

  resources :rooms do
    resources :reviews, only: [:create, :destroy]
  end

  resources :conversations, only: [:index, :create] do
    resources :messages, only: [:index, :create]
  end

  get '/preload' => 'reservations#preload'
  get '/preview' => 'reservations#preview'
  
  get '/your_trips' => 'reservations#your_trips'
  get '/your_reservations' => 'reservations#your_reservations'

  post '/notify' => 'reservations#notify'
  post '/your_trips' => 'reservations#your_trips'

  get '/search' => 'pages#search'

  patch 'users/:id', controller: 'users', action: :update
  put 'users/:id', controller: 'users', action: :update

  get '/problem_tickets' => 'admin#problem_tickets'

  get '/create_user' => 'admin#create'

  get '/admin_panel' => 'admin#admin_panel'

  get '/admin_panel_users' => 'admin#admin_panel_users'

  get '/admin_panel_bookings' => 'admin#admin_panel_bookings'

  get '/search_for_bookings' => 'admin#bookings_search'

  get '/search_for_users' => 'admin#users_search'

  put '/edit_user' => 'user#update'

  get '/admin_user_edit' => 'users#admin_user_edit'

end
