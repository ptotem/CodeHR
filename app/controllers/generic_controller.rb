class GenericController < ApplicationController

    #load_and_authorize_resource :only => [:index]

    def index
      @employee_master = EmployeeMaster.all
    end

    def new
      @class_name = params[:model_name]
      @form_config= t('config.'+@class_name+'.form.new')
      @form=@form_config[:fields]
      @employee_master = eval(@class_name).new

      instance_variable_set("@#{params[:model_name].underscore}",eval(@class_name).new)
      @new=true
      @fields = DynamicField.where(:oclass=>@class_name)
      @fields.each do |ss|
        instance_variable_get("@#{params[:model_name].underscore}").write_attribute(ss.name.to_sym,"")
      end

      if @class_name == "Rating"
        RatingScale.all.each do |rating|
          i=@rating.score_receiveds.build(rating_scale_id:rating._id,sr_name:rating.name)
          rating.scales.each do |j|
            i.rating_measures.build(:name => j.scale_name, :range_from => j.range_from, :range_to => j.range_to)
          end
        end
      end
    end

    def create
      instance_variable_set("@#{params[:model_name].underscore}",instance_eval(params[:model_name]).new(params[params[:model_name].underscore.to_sym]))

      respond_to do |format|
        if instance_variable_get("@#{params[:model_name].underscore}").save
          instance_variable_get("@#{params[:model_name].underscore}").save
          if !params[:process_id].nil?
            @pro=ProcessTr.find(params[:process_id])
            @pro.chits.create!(name:params[:model_name],ocname:params[:model_name],oid:instance_variable_get("@#{params[:model_name].underscore}")._id)
            @user=current_user
            @user.current_redirect_url=''
            @user.save
            @pro.step_trs[params[:seq].to_i].end_processing_step
          end
          @user=User.find(current_user._id)
          if !@user.current_redirect_url.blank?
            redirect_to @user.current_redirect_url
            return
          end
          format.html { redirect_to instance_variable_get("@#{params[:model_name].underscore}"), notice: 'Company master was successfully created.' }
          format.json { render json: instance_variable_get("@#{params[:model_name].underscore}"), status: :created, location: instance_variable_get("@#{params[:model_name].underscore}") }
        else
          #this is to display the validation error
          @class_name = params[:model_name]
          @form_config= t('config.'+@class_name+'.form.new')
          @form=@form_config[:fields]
          @new = true
          format.html { render action: "new" }
          format.json { render json: instance_variable_get("@#{params[:model_name].underscore}").errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      @class_name = params[:model_name]
      instance_variable_set("@#{params[:model_name].underscore}",eval(@class_name).find(params[:id]))
      respond_to do |format|
        if instance_variable_get("@#{params[:model_name].underscore}").update_attributes(params[params[:model_name].underscore.to_sym])

          instance_variable_get("@#{params[:model_name].underscore}").save
          if !params[:process_id].nil?
            @pro=ProcessTr.find(params[:process_id])
            @pro.chits.create!(name:params[:model_name],ocname:params[:model_name],oid:instance_variable_get("@#{params[:model_name].underscore}")._id)
            @user=current_user
            @user.current_redirect_url=''
            @user.save
            @pro.step_trs[params[:seq].to_i].end_processing_step
          end
          @user=User.find(current_user._id)
          if !@user.current_redirect_url.blank?
            redirect_to @user.current_redirect_url
            return
          end
          format.html { redirect_to instance_variable_get("@#{params[:model_name].underscore}"), notice: 'Slide was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { redirect_to instance_variable_get("@#{params[:model_name].underscore}"), notice: 'Slide could not be updated.' }
          format.json { render json: instance_variable_get("@#{params[:model_name].underscore}").errors, status: :unprocessable_entity }
        end
      end

    end

    def edit
      @class_name = params[:model_name]
      @form_config= t('config.'+params[:model_name]+'.form.edit')
      @form=@form_config[:fields] rescue ""
      instance_variable_set("@#{params[:model_name].underscore}",eval(@class_name).find(params[:id]))
      render :action => :new
    end

    def show
      @class_name = params[:model_name]
      instance_variable_set("@#{params[:model_name].underscore}",eval(@class_name).find(params[:id]))
      render "#{params[:model_name].underscore.pluralize}/show"
    end

    def approval
      @class_name = params[:model_name]
      instance_variable_set("@#{params[:model_name].underscore}",eval(@class_name).find(params[:id]))
    end

    def approve_emp_master
      render :text => "hello"
      return
    end

    #Function to handle tagging for EmployeeMaster
    def employeemaster_tagging_role
      @employee_master=EmployeeMaster.find(params[:id])
    end

    def employeemaster_tagging_groupmaster
      @employee_master=EmployeeMaster.find(params[:id])
    end

    def employeemaster_tagging_manager
      @employee_master=EmployeeMaster.find(params[:id])
    end

    def role_tagging
      #render :text => params
      #return
      @employee_master=EmployeeMaster.find(params[:id])
      @employee_master.role=params[:role_id]
      @employee_master.save
      if !params[:process_id].nil?
        @pro=ProcessTr.find(params[:process_id])
        @pro.chits.create!(name:"Role",ocname:"Role",oid:@employee_master.role)
        @user=current_user
        @user.current_redirect_url=''
        @user.save
        @pro.step_trs[params[:seq].to_i].end_processing_step
      end

      @user=User.find(current_user._id)
      if !@user.current_redirect_url.blank?
        redirect_to @user.current_redirect_url
        return
      end
    end

    def group_tagging
      @employee_master=EmployeeMaster.find(params[:id])
      @employee_master.group_master_id=params[:group_id]
      @employee_master.save
      if !params[:process_id].nil?
        @pro=ProcessTr.find(params[:process_id])
        @pro.chits.create!(name:"Group",ocname:"GroupMaster",oid:@employee_master.group_master_id)
        @user=current_user
        @user.current_redirect_url=''
        @user.save
        @pro.step_trs[params[:seq].to_i].end_processing_step
      end

      @user=User.find(current_user._id)
      if !@user.current_redirect_url.blank?
        redirect_to @user.current_redirect_url
        return
      end
    end

    def manager_tagging
      @employee_master=EmployeeMaster.find(params[:id])
      @employee_master.reporting_tos.create!(:reporting_officer_id => params[:manager_id])
      @employee_master.save
      if !params[:process_id].nil?
        @pro=ProcessTr.find(params[:process_id])
        @pro.chits.create!(name:"Manager",ocname:"EmployeeMaster",oid:@employee_master.reporting_tos.first.reporting_officer_id)
        @user=current_user
        @user.current_redirect_url=''
        @user.save
        @pro.step_trs[params[:seq].to_i].end_processing_step
      end

      @user=User.find(current_user._id)
      if !@user.current_redirect_url.blank?
        redirect_to @user.current_redirect_url
        return
      end
    end


    #Function to handle excel import of EmployeeMaster Model
    def import_employee_masters
      render :layout => false
    end

    def importing_employee_masters
      if request.post? && params[:file].present?
        EmployeeMaster.import(params[:file])
      else
        redirect_to '/import_employee_masters', notice: "Slides couldn't be imported."
      end
    end


    def approved_form
      render :json =>params
      return
    end



    def new_process_creation
      @object = t('forms.Rating.object')
      #@object = t('forms.CandidateMaster.object')
      instance_variable_set("@#{@object.underscore}",eval(@object).new)
      @form_config = t('forms.Rating')
      #@form_config = t('forms.CandidateMaster')
      @form = @form_config[:fields]
      @real_obj = eval(@object).new
      @form_nested_obj = @real_obj.instance_eval(@form[:col1][:score_receiveds][:attribute]).build
      #render :json => @form[:col1][:score_recieveds][:attribute]
      #return
    end

    def fill_from_creation_process
      @model_name = params[:model_name]

      @form_config = t('forms.'+@model_name)
      @fields = @form_config[:fields]
      @score = Rating.new.score_receiveds.build

      @num = eval(@model_name).all.length rescue 1
      @dynamic_code = t('config.AutoCode.'+@model_name+'.text')+sprintf('%0'+t('config.AutoCode.'+@model_name+'.digit')+'d',(@num+1)) rescue 1

      #@approval = true
      #@notification =true
    end

    def fill_bulk_creation_form
      @model_name = params[:model_name]
      @form_config = t('forms.'+@model_name)
      @fields = @form_config[:fileds]
      @process_transact = ProcessTransact.find(params[:process_id])
      #todo: To write a view code for saving the file in process transact using bulk upload only
    end

    def render_subform
      @fields1 = t('forms.'+params[:fi][0]+'.fields.tabs')

      if (@fields1.length < 2 and @fields1[:tab1][:cols].has_key?(:type))
        respond_to do |format|
          format.html { render :partial => 'generic/nested_table_sub_form', :locals => {:fi =>params[:fi][0],:form_index => params[:form_index][0], :main_form => params[:main_form][0] } } # index.html.erb
          format.json { render json: @results, :callback => params[:callback] }
        end
      else
        respond_to do |format|
          format.html { render :partial => 'generic/subform', :locals => {:fi =>params[:fi][0],:form_index => params[:form_index][0], :main_form => params[:main_form][0] } } # index.html.erb
          format.json { render json: @results, :callback => params[:callback] }
        end
      end

    end

    def render_nested_subform
      respond_to do |format|
        format.html { render :partial => 'generic/nested_sub_form', :locals => {:new_fields => params[:new_fields][0], :main_form => params[:main_form][0], :fi => params[:fi][0], :form_index => params[:form_index][0], :this_sf =>params[:this_sf][0], :my_index =>(params[:my_index][0].to_i+1) } } # index.html.erb
        format.json { render json: @results, :callback => params[:callback] }
      end
    end

    def render_approver_form
      respond_to do |format|
        format.html { render :partial => 'generic/approvers', :locals => {:counter => params[:counter][0]} } # index.html.erb
        format.json { render json: @results, :callback => params[:callback] }
      end
    end

    def review_bulk_form
      #render :json => params
      #return
      @process_transact = ProcessTransact.find(params[:process_id])
      @process_transact.update_attributes(params[:process_transact])
      @process_transact.save
      if !params[:process_id].nil?
        @pro=ProcessTransact.find(params[:process_id])
        @user=current_user
        @user.current_redirect_url=''
        @user.save
        @pro.step_transacts[params[:seq].to_i].end_processing_step
      end
      @user=User.find(current_user._id)
      if !@user.current_redirect_url.blank?
        redirect_to @user.current_redirect_url
        return
      end
    end

    def review_filled_form
      @process_transact = ProcessTransact.find(params[:process_id])
      @process_transact.class_obj = params[params[:model_name].to_sym]
      @process_transact.save
      if !params[:process_id].nil?
        @pro=ProcessTransact.find(params[:process_id])
        @user=current_user
        @user.current_redirect_url=''
        @user.save
        @pro.step_transacts[params[:seq].to_i].end_processing_step
      end
      @user=User.find(current_user._id)
      if !@user.current_redirect_url.blank?
        redirect_to @user.current_redirect_url
        return
      end

      redirect_to '/', notice: "Form is Filled"
    end

    def new_approval
      @pro = ProcessTransact.find(params[:process_id])
      @step = @pro.step_transacts[params[:seq].to_i]
      @cls=@pro.class_obj
      @class_name=@pro.step_transacts[0].obj_name
      @form_config = t('forms.'+@class_name)
      @fields = @form_config[:fields]
    end

    def params_mapping
      @model_name1 = params[:model_name]
      @model_name = t('forms.'+@model_name1+'.object')
      #@form_config = t('forms.'+@model_name)
      #@fields = @form_config[:fields]
      @aa= Array.new
      eval(@model_name).fields.keys.each do |i|
        @aa << i
      end
      #@fields[:tabs].map{|i,v| v[:cols].values rescue nil}.flatten.compact.each do |i|
      #  @aa << i.values.map{|i| i[:attribute]}
      #end
      render :json =>@aa.flatten
      return
    end

    def params_mapping1
      @model_name = MasterPro.find(params[:model_name]).master_steps[0].action_class
      #@form_config = t('forms.'+@model_name)
      #@fields = @form_config[:fields]
      #@aa= Array.new
      #@fields[:tabs].map{|i,v| v[:cols].values rescue nil}.flatten.compact.each do |i|
      #  @aa << i.values.map{|i| i[:attribute]}
      #end
      @aa= Array.new
      eval(@model_name).fields.keys.each do |i|
        @aa << i
      end
      render :json =>@aa.flatten
      return
    end

    def update_form
      @model_name = params[:model_name]
      @form_config = t('forms.'+@model_name)
      @fields = @form_config[:fields]
      @object_at_hand  = @model_name.camelize.constantize.find(params[:id])
      @approval = true
      @notification =true
    end

    #def update_form
    #  render :json => params
    #  return
    #end
end
