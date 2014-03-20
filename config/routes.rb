CodeHR::Application.routes.draw do

  resources :container_lists


  resources :rating_measures


  resources :planning_manpowers


  resources :salary_strucutures


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

  resources :master_pros

  resources :user_tasks

  resources :approval_mats

  resources :band_masters

  resources :d_reports

  resources :process_transacts

  resources :ability_matrices

  resources :container_lists

  #
  #devise_for :admin_users, ActiveAdmin::Devise.config, ActiveAdmin::Devise.config
  #ActiveAdmin.routes(self)
  #
  devise_for :users
  #ActiveAdmin.routes(self)

  match '/reports' => 'welcomes#report', :as=> :report
  match '/my_report' => 'welcomes#my_report', :as=> :my_report
  match '/show_report' => 'd_reports#show_report', :as=> :show_report
  match '/get_fields/:class_name' => 'welcomes#get_fields', :as=> :get_fields
  match '/get_data' => 'welcomes#get_data', :as=> :get_data

  match '/get_dropdown_data' => 'master_pros#get_dropdown_data', :as=> :get_dropdown_data

  match '/process_transacts/new/(:master_pro_id)' => 'process_transacts#new', :as=> :process_transacts_with_master_pro

  match '/creation/:model_name/(:process_id)/(:seq)' => 'generic#new', :as => :creation
  match '/updation/:model_name/:id/(:process_id)/(:seq)' => 'generic#edit', :as => :updation
  match '/deletion/:model_name/:id/(:process_id)/(:seq)' => 'generic#destroy', :as => :deletion
  match '/approval/:model_name/:id/(:approval_id)/(:process_id)/(:seq)' => 'generic#approval', :as => :approval
  match '/gshow/:model_name/:id' => 'generic#show', as: :gshow

  match '/approval_updation/:id/(:process_id)/(:seq)' => 'approval_mats#edit', :as => :approval
  match '/send_approval_request/:id'=>'approval_mats#send_approval_request'

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

  match 'import_ratings' => 'ratings#import_ratings', :as => :import_ratings
  match 'importing_ratings' => 'ratings#importing_ratings', :as => :importing_ratings

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


  match '/approve_process/:approval_id/:process_id/:step_no/:approver_id' =>'process_transacts#approve_process', :as => :approved_master
  match '/reject_process/:approval_id/:process_id/:step_no/:approver_id' =>'process_transacts#reject_process', :as => :rejected_master

  match '/doc_master_approval/:id' =>'document_masters#doc_master_approval', :as => :doc_master_approval
  match '/approve_doc_master' =>'document_masters#approve_doc_master', :as => :approve_doc_master
  match '/notifications'=>'notification_masters#notifications', :as => :notifications
  match '/tasks'=>'user_tasks#tasks', :as => :tasks


  match '/destroy_all_notifications' =>'notification_masters#destroy_all_notifications', :as => :destroy_all_notifications
  match '/destroy_all_user_tasks' =>'user_tasks#destroy_all_user_tasks', :as => :destroy_all_user_tasks

  match '/get_value/:id'=>'process_trs#get_value'

  match '/new_process_creation_from' =>'generic#new_process_creation'

  match '/fillform/:model_name/(:process_id)/(:seq)' => 'generic#fill_from_creation_process'
  match '/fillbulkform/:model_name/(:process_id)/(:seq)' => 'generic#fill_bulk_creation_form'
  match '/updateform/:model_name/:id/(:process_id)/(:seq)' => 'generic#update_form'
  match '/review_form' => 'generic#review_filled_form'
  match '/review_bulk_form' => 'generic#review_bulk_form'

  match '/params_mapping/:model_name' => 'generic#params_mapping', :as => :params_mapping
  #match '/render_nested_subform/:new_fields/:main_form/:fi/:form_index/:this_sf/:my_index' => 'generic#render_nested_subform'
  match '/render_nested_subform' => 'generic#render_nested_subform', :as => :nested_subform
  match '/subform' => 'generic#render_subform', :as => :subform

  match '/render_approver_form' => 'generic#render_approver_form', :as => :approver_form

  match '/approval_pm_form' => 'master_pros#approval_pm_form', :as => :approval_pm_form
  match '/approver_pm_form' => 'master_pros#approver_pm_form', :as => :approver_pm_form
  match '/notification_pm_form' => 'master_pros#notification_pm_form', :as => :notification_pm_form

  match '/new_approval/(:approval_id)/(:process_id)/(:seq)' => 'generic#new_approval'
  #match '/approved_form/(:approval_id)/(:process_id)/(:seq)' => 'generic#approved_form',:as => "approved_form"
  match '/approved_form' => 'generic#approved_form'


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
