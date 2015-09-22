Rails.application.routes.draw do
  devise_for :users
  get 'home/index'
  get 'home/index2'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'users#new'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  get 'accept_request/:id' => 'requests#accept_request', as: :accept_request
  get 'reject_request/:id' => 'requests#reject_request', as: :reject_request
  get '/message/:id' => 'messages#chatbox', as: :chatbox
  get '/message' => 'messages#chatbox'
  get 'dashboard' => 'home#dashboard', as: :dashboard
  get 'requests' => 'users#requests', as: :requests
  get 'coaches' => 'users#coaches', as: :coaches
  get 'messages' => 'users#messages', as: :messages
  get 'get-messages' => 'messages#get_messages', as: :get_messages
  get 'close_session/:id' => 'requests#closing', as: :closing_request
  get 'publish_session/:id' => 'requests#publish', as: :publish_request
  get 'archived_sessions' => "users#archived_messages"
  get 'archived_message/:id' => "messages#archived_chatbox", as: :archived_chatbox
  get 'published_sessions' => 'users#published_messages', as: :published
  get 'published_message/:id' => 'messages#published_chatbox', as: :published_chatbox
  get 'profile/:id' => 'users#profile', as: :profile_path
  get 'search_coaches/:type/:term' => 'users#coach_search', as: :coach_search
  get 'published_messages' => 'requests#published_messages'
  get 'archived_messages' => 'requests#archived_messages'
  get 'read-message/:id' => 'messages#change_status'

  post '/new-message' => 'messages#new_message', as: :new_message

  # Example resource route (maps HTTP verbs to controller actions automatically):
  resources :users do
    post :keep_online
  end
  resources :messages
  resources :requests

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
