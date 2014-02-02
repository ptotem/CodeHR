class CompensationComponentsController < InheritedResources::Base

  def new
    @form_config= t('config.CompensationComponent.form.new')
    @form=@form_config[:fields]
    @compensation_component = CompensationComponent.new

    #@rating.write_attribute(:test1, "")
    @fields = DynamicField.where(:oclass=>"CompensationComponent")
    @fields.each do |ss|
      @compensation_component.write_attribute(ss.name.to_sym,"")
    end
  end

  def edit
    @form_config= t('config.CompensationComponent.form.edit')
    @form=@form_config[:fields]
    @compensation_component = CompensationComponent.find(params[:id])
  end

end
