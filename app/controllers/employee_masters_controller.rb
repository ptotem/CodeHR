class EmployeeMastersController < InheritedResources::Base

  def new
    @employee_master = EmployeeMaster.new
    @employee_master.reporting_tos.build
    #@rating.write_attribute(:test1, "")
    @fields = DynamicField.where(:oclass=>"EmployeeMaster")
    @fields.each do |ss|
      @employee_master.write_attribute(ss.name.to_sym,"")
    end
  end

  def create
    #render :text => params
    #return
    @employee_master =EmployeeMaster.new(params[:employee_master])

    @employee_master.date_of_joining = Date.strptime(params[:employee_master][:date_of_joining], "%m/%d/%Y")

    @employee_master.date_of_birth =Date.strptime(params[:employee_master][:date_of_birth], "%m/%d/%Y")
    #render :json=>@employee_master
    #return
    @employee_master.user=User.create!(:email =>@employee_master.official_email, :password =>"password", :password_confirmation =>"password")
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
