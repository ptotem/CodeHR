class SalaryComponentMastersController < InheritedResources::Base

  def new
    @salary_component_master = SalaryComponentMaster.new
    #@rating.write_attribute(:test1, "")
    @fields = DynamicField.where(:oclass=>"SalaryComponentMaster")
    @fields.each do |ss|
      @salary_component_master.write_attribute(ss.name.to_sym,"")
    end
  end

end
