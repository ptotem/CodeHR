class RatingsController < InheritedResources::Base

  #def new
  #  @form_config= t('config.Rating.form.new')
  #  @form=@form_config[:fields]
  #  @form = @form.sort_by{|_,v| v[:sequence]}
  #
  #  @rating = Rating.new
  #  @rating.score_receiveds.build
  #  @fields = DynamicField.where(:oclass=>"Rating")
  #  @conf=RatingConf.all.asc(:col_sequence)-RatingConf.where(:col_sequence=>nil)
  #  @fields.each do |ss|
  #    @rating.write_attribute(ss.name.to_sym,"")
  #  end
  #end

  def new
    @form_config= t('config.Rating.form.new')
    @form=@form_config[:fields]
    @rating = Rating.new
    RatingScale.all.each do |rc|
      @rating.score_receiveds.build()
    end
    #@rating.write_attribute(:test1, "")
    @fields = DynamicField.where(:oclass=>"Rating")
    @fields.each do |ss|
      @rating.write_attribute(ss.name.to_sym,"")
    end
  end

  def create
    #render :json => params
    #return
  end


  def edit
    @form_config= t('config.Rating.form.edit')
    @form=@form_config[:fields]
    @form = @form.sort_by{|_,v| v[:sequence]}
    @rating=Rating.find(params[:id])
  end

  #def create
  #  render :text => params
  #  return
  #end
end
