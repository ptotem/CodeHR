class RatingsController < InheritedResources::Base

  def new
    @form_config= t('config.Rating.form.new')
    @form=@form_config[:fields]
    @form = @form.sort_by{|_,v| v[:sequence]}

    @rating = Rating.new
    @rating.score_receiveds.build
    @fields = DynamicField.where(:oclass=>"Rating")
    @conf=RatingConf.all.asc(:col_sequence)-RatingConf.where(:col_sequence=>nil)
    @fields.each do |ss|
      @rating.write_attribute(ss.name.to_sym,"")
    end
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
