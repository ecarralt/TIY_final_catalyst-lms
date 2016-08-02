Rails.application.routes.draw do


  root 'welcome#catalyst', as: :welcome

  post '/' => 'sessions#create', as: :create_sign_in
  get "/logout" => "sessions#delete", as: :sign_out

  # get 'students/dashboard' => 'students#dashboard', as: :dashboard

  get 'lessons/student_dashboard' => 'lessons#student_dashboard', as: :lessons
  get 'lessons/student_review' => 'lessons#student_review', as: :student_review
  get 'lessons/student_feedback' => 'lessons#student_feedback', as: :student_feedback

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

  # patch 'assignments/:id/update_arecord' => 'assignmentrecords#update_arecord', as: :update_grade

  # post 'assignments/:id/edit_arecord' => 'assignments#edit_arecord', as: :edit_arecord

  post 'assignmentrecords/create/:a_id' => 'assignmentrecords#create', as: :create_arecord
  patch 'assignmentrecords/:id/update' => 'assignmentrecords#update', as: :update_arecord
  get 'assignmentrecords/index' => 'assignmentrecords#index', as: :arecords
  get 'assignmentrecords/:id' => 'assignmentrecords#show', as: :arecord

  #navigation and change to complete status
  get 'lessonrecords/create/:l_id/:u_id' => 'lessonrecords#create', as: :create_lrecord

  #teachers viewing student records
  get 'students/index' => "students#index", as: :students
  get 'students/:id' => "students#show", as: :student

  get 'progrssreports/new' => 'progressreports#new', as: :new_pr
  get 'progrssreports/new2' => 'progressreports#new2', as: :new2_pr
  post 'progressreports/create/:st_id/' => 'progressreports#create', as: :create_pr


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
