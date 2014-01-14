class EmployeeMastersController < InheritedResources::Base

  def new
    @form_config= t('config.EmployeeMaster.form.new')
    @form=@form_config[:fields]

    @employee_master = EmployeeMaster.new
    #@employee_master.reporting_tos.build
    #@rating.write_attribute(:test1, "")
    @fields = DynamicField.where(:oclass=>"EmployeeMaster")
    @fields.each do |ss|
      @employee_master.write_attribute(ss.name.to_sym,"")
    end
  end

  def create
    @employee_master =EmployeeMaster.new(params[:employee_master])
    @employee_master.date_of_joining = Date.strptime(params[:employee_master][:date_of_joining], "%m/%d/%Y")
    @employee_master.date_of_birth =Date.strptime(params[:employee_master][:date_of_birth], "%m/%d/%Y")
    @employee_master.user=User.create!(:email =>@employee_master.official_email, :password =>"password", :password_confirmation =>"password")
    @employee_master.save

    #process_redirection

    if !params[:process_id].nil?
      @pro=ProcessTr.find(params[:process_id])
      @pro.chits.create!(name:"User",ocname:"EmployeeMaster",oid:@employee_master._id)
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
      if @employee_master.save
        format.html { redirect_to @employee_master, notice: 'Company master was successfully created.' }
        format.json { render json: @employee_master, status: :created, location: @employee_master }
      else
        format.html { render action: "new" }
        format.json { render json: @employee_master.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @form_config= t('config.EmployeeMaster.form.edit')
    @form=@form_config[:fields]
    @employee_master = EmployeeMaster.find(params[:id])
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
    #render :text => params[:file][:original_filename]

    if request.post? && params[:file].present?
      EmployeeMaster.import(params[:file])
      #redirect_to '/employee_masters', notice: "Slides imported."
    else
      redirect_to '/import_employee_masters', notice: "Slides couldn't be imported."
    end

  end

end
