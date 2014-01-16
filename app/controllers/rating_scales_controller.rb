class RatingScalesController < InheritedResources::Base

  def new
    @form_config= t('config.RatingScale.form.new')
    @form=@form_config[:fields]

    @rating_scale = RatingScale.new
    @rating_scale.scales.build
    #@rating.write_attribute(:test1, "")
    @fields = DynamicField.where(:oclass=>"RatingScale")
    @fields.each do |ss|
      @rating_scale.write_attribute(ss.name.to_sym,"")
    end
  end

  def edit
    @form_config= t('config.RatingScale.form.edit')
    @form=@form_config[:fields]
    @rating_scale = RatingScale.find(params[:id])
  end

end
