class JobDescriptionMastersController < InheritedResources::Base

  def new
    @form_config= t('config.JobDescriptionMaster.form.new')
    @form=@form_config[:fields]

    @job_description_master = JobDescriptionMaster.new
    @job_description_master.qualifications.build
    @job_description_master.manpower_plannings.build
    @job_description_master.vacancy_masters.build
    #@rating.write_attribute(:test1, "")
    @fields = DynamicField.where(:oclass=>"JobDescriptionMaster")
    @fields.each do |ss|
      @job_description_master.write_attribute(ss.name.to_sym,"")
    end
  end

  def edit
    @form_config= t('config.JobDescriptionMaster.form.edit')
    @form=@form_config[:fields]
    @job_description_master = JobDescriptionMaster.find(params[:id])
  end

end
