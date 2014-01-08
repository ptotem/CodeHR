CodeHR::Application.routes.draw do

  resources :employee_details


  resources :clients

  resources :group_masters


  resources :process_trs



  mount RailsAdmin::Engine => '/power_admin', :as => 'rails_admin'

  resources :roles


  resources :compensation_components


  resources :ratings


  resources :rating_scales


  resources :vacancy_schedulings


  resources :interview_types


  resources :vacancy_masters


  resources :manpower_plannings


  resources :salary_component_masters


  resources :notification_masters


  resources :document_masters


  resources :document_template_masters


  resources :job_description_masters


  resources :candidate_masters


  resources :vendor_masters


  resources :employee_masters


  resources :company_masters

  #
  #devise_for :admin_users, ActiveAdmin::Devise.config, ActiveAdmin::Devise.config
  #ActiveAdmin.routes(self)
  #
  devise_for :users
  #ActiveAdmin.routes(self)

  match 'groupmaster_creation/:process_id/:seq' => 'group_masters#new', :as => :group_creation
  match 'groupmaster_updation/:id/:process_id/:seq' => 'group_masters#edit', :as => :group_updation
  match 'groupmaster_deletion/:id/:process_id/:seq' => 'group_masters#destroy', :as => :group_updation

  match 'role_creation/:process_id/:seq' => 'roles#new', :as => :role_creation
  match 'role_updation/:id/:process_id/:seq' => 'roles#edit', :as => :role_updation
  match 'role_deletion/:id/:process_id/:seq' => 'roles#destroy', :as => :role_deletion

  match 'import_employee_masters' => 'employee_masters#import_employee_masters', :as => :import_employee_masters
  match 'importing_employee_masters' => 'employee_masters#importing_employee_masters', :as => :importing_employee_masters

  match 'import_group_masters' => 'group_masters#import_group_masters', :as => :import_group_masters
  match 'importing_group_masters' => 'group_masters#importing_group_masters', :as => :importing_group_masters

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
  root :to => 'ratings#new'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
