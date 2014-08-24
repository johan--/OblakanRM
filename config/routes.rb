OblakanRM::Application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => 'users/omniauth_callbacks' }

  devise_scope :user do
    get 'sign_in', :to => 'users/sessions#new', :as => :new_user_session
    get 'sign_in', :to => 'users/sessions#new', :as => :new_session
    get 'sign_out', :to => 'users/sessions#destroy', :as => :destroy_user_session
  end

  root 'application#index'

  concern :commentable do
    resources :comments
  end

  concern :image_attachable do
    resources :photos
  end

  concern :subscribable do
    resources :subscribers
  end

  namespace :api, defaults: { format: 'json' } do
    resources :reports, concerns: [:commentable, :subscribable]
    resources :users
    resources :statuses
    resources :categories
    resources :comments
    resources :photos
    resources :subscribers
    post 'photos/upload', to: 'photos#upload', as: :photo_upload
    post 'comments/:id/announce', to: 'comments#announce', as: :comment_announce
    post 'reports/geocode/', to: 'reports#geocode'
  end

  get '/unsubscribe/:email/:code', to: 'application#index', as: :unsubscribe
  get '/reports/:id', to: 'application#index', as: :report
  get '/*path' => 'application#index'

  #get '/change_locale/:locale' => 'application#change_locale'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
