CodeHR::Application.routes.draw do

  resources :welcomes


  resources :rating_confs


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

  resources :process_masters

  resources :user_tasks

  resources :approval_mats

  #
  #devise_for :admin_users, ActiveAdmin::Devise.config, ActiveAdmin::Devise.config
  #ActiveAdmin.routes(self)
  #
  devise_for :users
  #ActiveAdmin.routes(self)

  match '/reports' => 'welcomes#report', :as=> :report
  match '/get_fields/:class_name' => 'welcomes#get_fields', :as=> :get_fields
  match '/get_data' => 'welcomes#get_data', :as=> :get_data

  match '/creation/:model_name/(:process_id)/(:seq)' => 'generic#new', :as => :creation
  match '/updation/:model_name/:id/(:process_id)/(:seq)' => 'generic#edit', :as => :updation
  match '/deletion/:model_name/:id/(:process_id)/(:seq)' => 'generic#destroy', :as => :deletion
  match '/approval/:model_name/:id/(:approval_id)/(:process_id)/(:seq)' => 'generic#approval', :as => :approval
  match '/gshow/:model_name/:id' => 'generic#show', as: :gshow

  match '/gen_create/:model_name' => 'generic#create',:as=>:generic_create
  match '/gen_update/:model_name/:id' => 'generic#update',:as=>:generic_update

  match 'groupmaster_creation/:process_id/:seq' => 'group_masters#new', :as => :group_creation
  match 'groupmaster_updation/:id/:process_id/:seq' => 'group_masters#edit', :as => :group_updation
  match 'groupmaster_deletion/:id/:process_id/:seq' => 'group_masters#destroy', :as => :group_updation

  match 'role_creation/:process_id/:seq' => 'roles#new', :as => :role_creation
  match 'role_updation/:id/:process_id/:seq' => 'roles#edit', :as => :role_updation
  match 'role_deletion/:id/:process_id/:seq' => 'roles#destroy', :as => :role_deletion

  match 'import_employee_masters' => 'employee_masters#import_employee_masters', :as => :import_employee_masters
  match 'importing_employee_masters' => 'employee_masters#importing_employee_masters', :as => :importing_employee_masters

  #match 'import_candidate_masters' => 'employee_masters#import_employee_masters', :as => :import_employee_masters
  #match 'importing_employee_masters' => 'employee_masters#importing_employee_masters', :as => :importing_employee_masters

  match 'import_group_masters' => 'group_masters#import_group_masters', :as => :import_group_masters
  match 'importing_group_masters' => 'group_masters#importing_group_masters', :as => :importing_group_masters

  match '/get_column_data' => 'process_masters#get_data', :as => :get_column_data


  match '/employeemaster_creation/:process_id/:seq'=>'employee_masters#new', :as=>:employee_creation
  match '/manpowerplanning_creation/:process_id/:seq'=>'manpower_plannings#new', :as=>:manpowerplan_creation
  match '/manpowerplanning_release/:id/:process_id/:seq'=>'manpower_plannings#mp_release', :as=>:manpowerplan_release

  match '/manpowerplanning_released/:id/:process_id/:seq'=>'manpower_plannings#release', as: :mp_released
  #match '/manpowerplanning_released/:id/:process_id/:seq'=>'manpower_plannings#release', as: :mp_released

  match '/employeemaster_tagging_role/:id/:process_id/:seq' =>'employee_masters#employeemaster_tagging_role', :as => :employeemaster_tagging_role
  match '/employeemaster_tagging_groupmaster/:id/:process_id/:seq' =>'employee_masters#employeemaster_tagging_groupmaster', :as => :employeemaster_tagging_groupmaster
  match '/employeemaster_tagging_manager/:id/:process_id/:seq' =>'employee_masters#employeemaster_tagging_manager', :as => :employeemaster_tagging_manager

  match '/role_tag' =>'employee_masters#role_tagging', :as => :role_tag
  match '/group_tag' =>'employee_masters#group_tagging', :as => :group_tag
  match '/manager_tag' =>'employee_masters#manager_tagging', :as => :manager_tag

  match '/employeemaster_approval/:id/:process_id/:step_no/:approval_id' =>'employee_masters#emp_master_approval', :as => :emp_master_approval
  match '/manpowerplanning_approval/:id/:process_id/:step_no/:approval_id' =>'manpower_plannings#mp_approval', :as => :mp_approval


  match '/approve_process/:approval_id/:process_id/:step_no/:approver_id' =>'process_trs#approve_process', :as => :approve_emp_master
  match '/reject_process/:approval_id/:process_id/:step_no/:approver_id' =>'process_trs#reject_process', :as => :approve_emp_master

  match '/doc_master_approval/:id' =>'document_masters#doc_master_approval', :as => :doc_master_approval
  match '/approve_doc_master' =>'document_masters#approve_doc_master', :as => :approve_doc_master
  match '/notifications'=>'notification_masters#notifications', :as => :notifications
  match '/tasks'=>'user_tasks#tasks', :as => :tasks


  match '/destroy_all' =>'notification_masters#destroy_all', :as => :destroy_all_notifications


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
  root :to => 'welcomes#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
