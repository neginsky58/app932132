Binbuds::Application.routes.draw do
  
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  #devise_for :users
  devise_scope :user do
    get 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_session
  end  

  constraints(host: /^admin\./i) do
    get '/login' => 'admin#new'
    get '/all-users' => 'admin#users', as: 'admin_all_users'
    get '/all-circles' => 'admin#circles', as: 'admin_all_circles'
    get '/settings' => 'admin#settings', as: 'admin_settings'
    get '/new_circle' => 'admin#new_circle', as: 'admin_new_circle'
    post '/create_circle' => 'admin#create_circle', as: 'admin_create_circle'

    # get '(*any)' => redirect { |params, request|
    #   URI.parse(request.url).tap { |uri| uri.host.sub!(/^admin\./i, '') }.to_s
    # }
    resources :circles    
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"

  resources :products
  resources :items
  resources :users do 
    resources :favorites
  end
  resources :admin


  root 'items#index'

  get '/friends'    => 'users#friends'
  get '/settings'   => 'users#settings', as: 'settings'


  

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
