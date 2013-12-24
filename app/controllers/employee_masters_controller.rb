class EmployeeMastersController < InheritedResources::Base

  def new
    @employee_master = EmployeeMaster.new
    #@rating.write_attribute(:test1, "")
    @fields = DynamicField.where(:oclass=>"EmployeeMaster")
    @fields.each do |ss|
      @employee_master.write_attribute(ss.name.to_sym,"")
    end
  end

end
