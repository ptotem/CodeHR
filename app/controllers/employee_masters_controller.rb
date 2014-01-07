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

  #def create
  #  #render :text => params
  #  #return
  #  @employee_master =EmployeeMaster.new(params[:employee_master])
  #  @employee_master.save
  #end

end
