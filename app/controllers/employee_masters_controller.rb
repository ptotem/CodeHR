class EmployeeMastersController < InheritedResources::Base

  def new
    @employee_master = EmployeeMaster.new
    @employee_master.reporting_tos.build
    @employee_master.employment_hists.build
    @employee_master.educations.build
    @employee_master.family_details.build
    @employee_master.pf_nominations.build
    @employee_master.esis_nominations.build
    #@rating.write_attribute(:test1, "")
    @fields = DynamicField.where(:oclass=>"EmployeeMaster")
    @fields.each do |ss|
      @employee_master.write_attribute(ss.name.to_sym,"")
    end
  end
  #
  #def create
  #  #render :text => params
  #  #return
  #  @employee_master =EmployeeMaster.new(params[:employee_master])
  #  @employee_master.save
  #end

end
