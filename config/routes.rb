Esupport::Application.routes.draw do
  get :set_locale, controller:"application"
  
  get "serial_numbers/serial_number_with_part"
  resources :serial_numbers


  resources :error_reports


  get "orders/cellphone" 
  get "orders/computer" 
  resources :orders do
    get :autocomplete_computer_model, :on => :collection
    get :autocomplete_cellphone_model, :on => :collection
    get :autocomplete_part_name, :on => :collection
    get :autocomplete_serial_number, :on => :collection
    get :autocomplete_client_need_name, :on => :collection
    get :autocomplete_client_first_name, :on => :collection
  end
  resources :orders

  get "client_needs/get_client_need_by_name"
  resources :client_needs

  get "bills/get_bill_by_client_id"
  resources :bills 


  resources :workshops


  resources :progresses

  resources :parts


  resources :computers


  resources :comments


  resources :cellphones

  devise_for :clients
  resources :clients


  resources :statuses


  devise_for :users

  resources :users


  resources :roles


  resources :branches


  get "welcome/index"

  get "system_info/index"

  
  devise_scope :user do
    get "devise/sessions/sign_out" => "devise/sessions#destroy", :as => :destroy_user_session
    match 'devise/registrations/:id/edit' => 'devise/registrations#edit', :as => :edit_user
    match 'devise/registrations/new' => 'welcome#index'
    match 'users/sign_up' => 'welcome#index'
  end
  
  

  
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
