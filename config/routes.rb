CodeHR::Application.routes.draw do

  get 'temporary_file_storage/new'

  resources :goals


  resources :pms_kra_kpi_tabs


  resources :pms_subgroups


  resources :pms_group_categories


  resources :left_panels


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

  match '/mark_read' => 'document_masters#mark_read', :as=> :mark_read, :via => [:get, :post]
  match '/reports' => 'welcomes#report', :as=> :report, :via => [:get, :post]
  match '/my_report' => 'welcomes#my_report', :as=> :my_report, :via => [:get, :post]
  match '/show_report' => 'd_reports#show_report', :as=> :show_report, :via => [:get, :post]
  match '/get_fields/:class_name' => 'welcomes#get_fields', :as=> :get_fields, :via => [:get, :post]
  match '/get_data' => 'welcomes#get_data', :as=> :get_data, :via => [:get, :post]

  match '/get_report_of/:employee_master_id' => 'welcomes#get_report_of', :as=> :get_report_of, :via => [:get, :post]
  match '/display_report_of' => 'welcomes#display_report_of', :as=> :display_report_of, :via => [:get, :post]
  match '/generate_pdf_report' => 'welcomes#generate_pdf_report', :as=> :generate_pdf_report, :via => [:get, :post]

  match '/get_dropdown_data' => 'master_pros#get_dropdown_data', :as=> :get_dropdown_data, :via => [:get, :post]

  match '/process_transacts/new/(:master_pro_id)' => 'process_transacts#new', :as=> :process_transacts_with_master_pro, :via => [:get, :post]

  match '/creation/:model_name/(:process_id)/(:seq)' => 'generic#new', :as => :creation, :via => [:get, :post]
  match '/updation/:model_name/:id/(:process_id)/(:seq)' => 'generic#edit', :as => :updation, :via => [:get, :post]
  match '/deletion/:model_name/:id/(:process_id)/(:seq)' => 'generic#destroy', :as => :deletion, :via => [:get, :post]
  match '/approval/:model_name/:id/(:approval_id)/(:process_id)/(:seq)' => 'generic#approval', :as => :approval, :via => [:get, :post]
  match '/gshow/:model_name/:id' => 'generic#show', as: :gshow, :via => [:get, :post]

  match '/approval_updation/:id/(:process_id)/(:seq)' => 'approval_mats#edit', :as => :approvalMat, :via => [:get, :post]
  match '/send_approval_request/:id'=>'approval_mats#send_approval_request', :via => [:get, :post]

  match '/gen_create/:model_name' => 'generic#create',:as=>:generic_create, :via => [:get, :post]
  match '/gen_update/:model_name/:id' => 'generic#update',:as=>:generic_update, :via => [:get, :post]

  match 'groupmaster_creation/:process_id/:seq' => 'group_masters#new', :as => :group_creation, :via => [:get, :post]
  match 'groupmaster_updation/:id/:process_id/:seq' => 'group_masters#edit', :as => :group_updation, :via => [:get, :post]
  match 'groupmaster_deletion/:id/:process_id/:seq' => 'group_masters#destroy', :as => :group_updation_delete, :via => [:get, :post]

  match 'role_creation/:process_id/:seq' => 'roles#new', :as => :role_creation, :via => [:get, :post]
  match 'role_updation/:id/:process_id/:seq' => 'roles#edit', :as => :role_updation, :via => [:get, :post]
  match 'role_deletion/:id/:process_id/:seq' => 'roles#destroy', :as => :role_deletion, :via => [:get, :post]

  match 'import_employee_masters' => 'employee_masters#import_employee_masters', :as => :import_employee_masters, :via => [:get, :post]
  match 'importing_employee_masters' => 'employee_masters#importing_employee_masters', :as => :importing_employee_masters, :via => [:get, :post]

  match 'import_roles' => 'roles#import_roles', :as => :import_roles, :via => [:get, :post]
  match 'importing_roles' => 'roles#importing_roles', :as => :importing_roles, :via => [:get, :post]

  match 'import_band_masters' => 'band_masters#import_band_masters', :as => :import_band_masters, :via => [:get, :post]
  match 'importing_band_masters' => 'band_masters#importing_band_masters', :as => :importing_band_masters, :via => [:get, :post]

  #match 'import_candidate_masters' => 'employee_masters#import_employee_masters', :as => :import_employee_masters
  #match 'importing_employee_masters' => 'employee_masters#importing_employee_masters', :as => :importing_employee_masters

  match 'import_group_masters' => 'group_masters#import_group_masters', :as => :import_group_masters, :via => [:get, :post]
  match 'importing_group_masters' => 'group_masters#importing_group_masters', :as => :importing_group_masters, :via => [:get, :post]

  match 'import_ratings' => 'ratings#import_ratings', :as => :import_ratings, :via => [:get, :post]
  match 'importing_ratings' => 'ratings#importing_ratings', :as => :importing_ratings, :via => [:get, :post]

  match '/get_column_data' => 'process_masters#get_data', :as => :get_column_data, :via => [:get, :post]


  match '/employeemaster_creation/:process_id/:seq'=>'employee_masters#new', :as=>:employee_creation, :via => [:get, :post]
  match '/manpowerplanning_creation/:process_id/:seq'=>'manpower_plannings#new', :as=>:manpowerplan_creation, :via => [:get, :post]
  match '/manpowerplanning_release/:id/:process_id/:seq'=>'manpower_plannings#mp_release', :as=>:manpowerplan_release, :via => [:get, :post]

  match '/manpowerplanning_released/:id/:process_id/:seq'=>'manpower_plannings#release', as: :mp_released, :via => [:get, :post]
  #match '/manpowerplanning_released/:id/:process_id/:seq'=>'manpower_plannings#release', as: :mp_released

  match '/employeemaster_tagging_role/:id/:process_id/:seq' =>'employee_masters#employeemaster_tagging_role', :as => :employeemaster_tagging_role, :via => [:get, :post]
  match '/employeemaster_tagging_groupmaster/:id/:process_id/:seq' =>'employee_masters#employeemaster_tagging_groupmaster', :as => :employeemaster_tagging_groupmaster, :via => [:get, :post]
  match '/employeemaster_tagging_manager/:id/:process_id/:seq' =>'employee_masters#employeemaster_tagging_manager', :as => :employeemaster_tagging_manager, :via => [:get, :post]

  match '/role_tag' =>'employee_masters#role_tagging', :as => :role_tag, :via => [:get, :post]
  match '/group_tag' =>'employee_masters#group_tagging', :as => :group_tag, :via => [:get, :post]
  match '/manager_tag' =>'employee_masters#manager_tagging', :as => :manager_tag, :via => [:get, :post]

  match '/employeemaster_approval/:id/:process_id/:step_no/:approval_id' =>'employee_masters#emp_master_approval', :as => :emp_master_approval, :via => [:get, :post]
  match '/manpowerplanning_approval/:id/:process_id/:step_no/:approval_id' =>'manpower_plannings#mp_approval', :as => :mp_approval, :via => [:get, :post]


  match '/approve_process/:approval_id/:process_id/:step_no/:approver_id' =>'process_transacts#approve_process', :as => :approved_master, :via => [:get, :post]
  match '/reject_process/:approval_id/:process_id/:step_no/:approver_id' =>'process_transacts#reject_process', :as => :rejected_master, :via => [:get, :post]

  match '/doc_master_approval/:id' =>'document_masters#doc_master_approval', :as => :doc_master_approval, :via => [:get, :post]
  match '/approve_doc_master' =>'document_masters#approve_doc_master', :as => :approve_doc_master, :via => [:get, :post]
  match '/notifications'=>'notification_masters#notifications', :as => :notifications, :via => [:get, :post]
  match '/tasks'=>'user_tasks#tasks', :as => :tasks, :via => [:get, :post]


  match '/destroy_all_notifications' =>'notification_masters#destroy_all_notifications', :as => :destroy_all_notifications, :via => [:get, :post]
  match '/destroy_all_user_tasks' =>'user_tasks#destroy_all_user_tasks', :as => :destroy_all_user_tasks, :via => [:get, :post]

  match '/get_value/:id'=>'process_trs#get_value', :via => [:get, :post]

  match '/new_process_creation_from' =>'generic#new_process_creation', :via => [:get, :post]

  match '/fillform/:model_name/(:process_id)/(:seq)' => 'generic#fill_from_creation_process', :via => [:get, :post]
  match '/fillbulkform/:model_name/(:process_id)/(:seq)' => 'generic#fill_bulk_creation_form', :via => [:get, :post]
  match '/updateform/:model_name/:id/(:process_id)/(:seq)' => 'generic#update_form', :via => [:get, :post]
  match '/review_form' => 'generic#review_filled_form', :as => :review_form, :via => [:get, :post]
  match '/review_bulk_form' => 'generic#review_bulk_form', :via => [:get, :post]

  match '/params_mapping/:model_name' => 'generic#params_mapping', :as => :params_mapping, :via => [:get, :post]
  match '/params_mapping1/:model_name' => 'generic#params_mapping1', :as => :params_mapping1, :via => [:get, :post]
  #match '/render_nested_subform/:new_fields/:main_form/:fi/:form_index/:this_sf/:my_index' => 'generic#render_nested_subform'
  match '/render_nested_subform' => 'generic#render_nested_subform', :as => :nested_subform, :via => [:get, :post]
  match '/subform' => 'generic#render_subform', :as => :subform, :via => [:get, :post]

  match '/render_approver_form' => 'generic#render_approver_form', :as => :approver_form, :via => [:get, :post]

  match '/approval_pm_form' => 'master_pros#approval_pm_form', :as => :approval_pm_form, :via => [:get, :post]
  match '/approver_pm_form' => 'master_pros#approver_pm_form', :as => :approver_pm_form, :via => [:get, :post]
  match '/notification_pm_form' => 'master_pros#notification_pm_form', :as => :notification_pm_form, :via => [:get, :post]

  match '/new_approval/(:approval_id)/(:process_id)/(:seq)' => 'generic#new_approval', :via => [:get, :post]
  #match '/approved_form/(:approval_id)/(:process_id)/(:seq)' => 'generic#approved_form',:as => "approved_form"
  get '/approved_form' => 'generic#approved_form'#, :via => [:get, :post]
  match '/remove_master_step' => 'master_pros#remove_master_step', :as => :remove_master_step, :via => [:get, :post]

  match '/approval_tracker/:process_id/:index' => 'approval_mats#track_approval', :as => :approval_tracker, :via => [:get, :post]

  match '/letters' => "letter_report#letter", :via => [:get, :post]

  match '/get_report_data/:stmt_id' => 'welcomes#get_data1', :via => [:get, :post]

  ####################################### Employee Assessment #####################################################
  match '/assessment_tracker/(:employee_id)' => 'welcomes#assessment_tracker', :as => :assessment_tracker, :via => [:get, :post]
  match '/employee_assessment/(:employee_id)' => 'welcomes#employee_assessment', :as => :assessment_tracker_emp, :via => [:get, :post]
  match '/manager_assessment/:employee_id' => 'welcomes#manager_assessment', :as => :manager_assessment, :via => [:get, :post]
  match '/goal_index/(:employee_id)' => 'welcomes#goal_index', :via => [:get, :post]#, :as => :assessment_tracker
  match '/subgoal_index/(:kra_id)/(:employee_id)/(:manager)' => 'welcomes#subgoal_index', :via => [:get, :post]#, :as => :assessment_tracker
  match '/subgoals/(:employee_id)/(:kra_id)/(:manager)' => 'welcomes#subgoals', :via => [:get, :post]#, :as => :assessment_tracker, :via => [:get, :post]
  match '/send_employee_data' => 'welcomes#send_employee_data', :via => [:get, :post]
  match '/pms_normalization_grp_wise/:group_master_id' => 'welcomes#pms_normalization_grp_wise', :via => [:get, :post]
  #################################################################################################################
  match '/pms_eval' => 'welcomes#pms_normalization', :via => [:get, :post]
  match '/self_assessment_list' => 'welcomes#self_assessment', :via => [:get, :post]
  match '/reportee_assessment_list' => 'welcomes#reportee_assessment', :via => [:get, :post]
  #################################################################################################################
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
