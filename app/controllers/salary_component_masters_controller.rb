class SalaryComponentMastersController < InheritedResources::Base

  def new
    @form_config= t('config.SalaryComponentMaster.form.new')
    @form=@form_config[:fields]
    @salary_component_master = SalaryComponentMaster.new
    #@rating.write_attribute(:test1, "")
    @fields = DynamicField.where(:oclass=>"SalaryComponentMaster")
    @fields.each do |ss|
      @salary_component_master.write_attribute(ss.name.to_sym,"")
    end
  end

  def edit
    @form_config= t('config.SalaryComponentMaster.form.edit')
    @form=@form_config[:fields]
    @salary_component_master = SalaryComponentMaster.find(params[:id])
  end

end
