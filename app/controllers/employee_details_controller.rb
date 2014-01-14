class EmployeeDetailsController < InheritedResources::Base

  def new
    @form_config= t('config.EmployeeDetail.form.new')
    @form=@form_config[:fields]
    @employee_detail = EmployeeDetail.new
    @employee_detail.employment_hists.build
    @employee_detail.educations.build
    @employee_detail.family_details.build
    @employee_detail.pf_nominations.build
    @employee_detail.esis_nominations.build
    @fields = DynamicField.where(:oclass=>"EmployeeDetail")
    @fields.each do |ss|
      @employee_detail.write_attribute(ss.name.to_sym,"")
    end
  end

  def edit
    @form_config= t('config.EmployeeDetail.form.edit')
    @form=@form_config[:fields]
    @employee_detail = EmployeeDetail.find(params[:id])
  end

end
