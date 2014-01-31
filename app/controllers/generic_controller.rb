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
    end

    def create
      instance_variable_set("@#{params[:model_name].underscore}",instance_eval(params[:model_name]).new(params[params[:model_name].underscore.to_sym]))
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
      respond_to do |format|
        if instance_variable_get("@#{params[:model_name].underscore}").save
          format.html { redirect_to instance_variable_get("@#{params[:model_name].underscore}"), notice: 'Company master was successfully created.' }
          format.json { render json: instance_variable_get("@#{params[:model_name].underscore}"), status: :created, location: instance_variable_get("@#{params[:model_name].underscore}") }
        else
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
      #@employee_master = EmployeeMaster.find(params[:id])
      @class_name = params[:model_name]
      instance_variable_set("@#{params[:model_name].underscore}",eval(@class_name).find(params[:id]))
      #render "#{params[:model_name].underscore.pluralize}/show"
      #render :text =>instance_variable_get("@#{params[:model_name].underscore}").class.fields.keys
      #return
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

end
