Binbuds::Application.routes.draw do
  
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  #devise_for :users
  devise_scope :user do
    get 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_session
  end  

  # constraints(host: /^admin\./i) do
  #   get '/login' => 'admin#new'
  #   get '/all-users' => 'admin#users', as: 'admin_all_users'
  #   get '/all-circles' => 'admin#circles', as: 'admin_all_circles'
  #   get '/settings' => 'admin#settings', as: 'admin_settings'
  #   get '/new_circle' => 'admin#new_circle', as: 'admin_new_circle'
  #   post '/create_circle' => 'admin#create_circle', as: 'admin_create_circle'

  #   # get '(*any)' => redirect { |params, request|
  #   #   URI.parse(request.url).tap { |uri| uri.host.sub!(/^admin\./i, '') }.to_s
  #   # }
  #   resources :circles do 
  #     collection do 
  #       post 'delete_selected'
  #     end
  #   end   
  # end




  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"

  resources :products
  resources :items do 
    collection do
      get 'mylist'
      get 'whatsnew'
    end
  end
  resources :users do 
    collection do 
      post 'join_circle'
    end
  end
  resources :photos
  resources :favorites do
    collection do
      post 'delete_selected'
    end
  end
  resources :admin, :as => 'admins' do


    collection do
      post 'delete_selected_users'
    end
   
  end

  get '/admin2/login' => 'admin#new'
  get '/admin2/all-users' => 'admin#users', as: 'admin_all_users'
  get '/admin2/all-circles' => 'admin#circles', as: 'admin_all_circles'
  get '/admin2/settings' => 'admin#settings', as: 'admin_settings'
  get '/admin2/new_circle' => 'admin#new_circle', as: 'admin_new_circle'
  post '/admin2/create_circle' => 'admin#create_circle', as: 'admin_create_circle'
  
  resources :circles do 
    collection do 
      post 'delete_selected'
    end
  end   
  # namespace :admin2 do
  #   get '/login' => 'admin#new'
  #   get '/all-users' => 'admin#users', as: 'admin_all_users'
  #   get '/all-circles' => 'admin#circles', as: 'admin_all_circles'
  #   get '/settings' => 'admin#settings', as: 'admin_settings'
  #   get '/new_circle' => 'admin#new_circle', as: 'admin_new_circle'
  #   post '/create_circle' => 'admin#create_circle', as: 'admin_create_circle'

  #   # get '(*any)' => redirect { |params, request|
  #   #   URI.parse(request.url).tap { |uri| uri.host.sub!(/^admin\./i, '') }.to_s
  #   # }
  #   resources :circles do 
  #     collection do 
  #       post 'delete_selected'
  #     end
  #   end   
  # end


  root 'users#join'

  get '/friends'    => 'users#friends'
  get '/settings'   => 'users#settings', as: 'settings'
  post '/join'       => 'users#join',     as: 'join'
  get '/join'       => 'users#join'
  get '/set-mine/:item_id'  => 'items#set_mine',  as: 'set_mine_item'
  post '/watchlist'  => 'items#watchlist', as: 'watchlist'
  post '/saleslist'  => 'items#saleslist', as: 'saleslist'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
