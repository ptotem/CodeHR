class VacancyMastersController < InheritedResources::Base

  def new
    @form_config= t('config.VacancyMaster.form.new')
    @form=@form_config[:fields]

    @vacancy_master = VacancyMaster.new
    #@rating.write_attribute(:test1, "")
    @fields = DynamicField.where(:oclass=>"VacancyMaster")
    @fields.each do |ss|
      @vacancy_master.write_attribute(ss.name.to_sym,"")
    end
  end

  def edit
    @form_config= t('config.VacancyMaster.form.edit')
    @form=@form_config[:fields]
    @vacancy_master = VacancyMaster.find(params[:id])
  end

end
