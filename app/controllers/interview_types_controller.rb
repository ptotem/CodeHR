class InterviewTypesController < InheritedResources::Base

  def new
    @form_config= t('config.InterviewType.form.new')
    @form=@form_config[:fields]

    @interview_type = InterviewType.new
    #@rating.write_attribute(:test1, "")
    @fields = DynamicField.where(:oclass=>"InterviewType")
    @fields.each do |ss|
      @interview_type.write_attribute(ss.name.to_sym,"")
    end
  end

  def edit
    @form_config= t('config.InterviewType.form.edit')
    @form=@form_config[:fields]
    @interview_type = InterviewType.find(params[:id])
  end

end
