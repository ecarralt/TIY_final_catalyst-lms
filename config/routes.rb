Rails.application.routes.draw do


  root 'welcome#catalyst', as: :welcome

  post '/' => 'sessions#create', as: :create_sign_in
  get "/logout" => "sessions#delete", as: :sign_out

  # get 'students/dashboard' => 'students#dashboard', as: :dashboard

  get 'lessons/dashboard' => 'lessons#dashboard', as: :lessons
  get 'lessons/new' => 'lessons#new', as: :new_lesson
  post 'lessons/create' => 'lessons#create', as: :create_lesson
  get 'lessons/:id' => 'lessons#show', as: :lesson
  get 'lessons/:id/edit' => 'lessons#edit', as: :edit_lesson
  patch 'lessons/:id/update' => 'lessons#update', as: :update_lesson
  delete 'lessons/:id/delete' => 'lessons#delete', as: :delete_lesson

  get 'assignments/index' => 'assignments#index', as: :assignments
  get 'assignments/new' => 'assignments#new', as: :new_assignment
  post 'assignments/create' => 'assignments#create', as: :create_assignment
  get 'assignments/:id' => 'assignments#show', as: :assignment
  get 'assignments/:id/edit' => 'assignments#edit', as: :edit_assignment
  patch 'assignments/:id/update' => 'assignments#update', as: :update_assignment
  delete 'assignments/:id/delete' => 'assignments#delete', as: :delete_assignment

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
