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
    RatingScale.all.each do |rating|
      i=@rating.score_receiveds.build(rating_scale_id:rating._id,sr_name:rating.name)
      rating.scales.each do |j|
        i.rating_measures.build(:name => j.scale_name, :range_from => j.range_from, :range_to => j.range_to)
      end
    end
    #RatingScale.all.each do |rc|
    #  @rating.score_receiveds.build()
    #end
    #@rating.write_attribute(:test1, "")
    @fields = DynamicField.where(:oclass=>"Rating")
    @fields.each do |ss|
      @rating.write_attribute(ss.name.to_sym,"")
    end
  end

  #def create
  #  #render :json => params
  #  #return
  #end


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

  def change_data
    @scale = params[:scale]

    #RatingScale.where(:name=>@scale).first.scales.each do |j|
    #  i.rating_measures.build(:name => j.scale_name, :range_from => j.range_from, :range_to => j.range_to)
    #end
  end

  #Function to handle excel import of Rating Model
  def import_ratings
    render :layout => false
  end

  def importing_ratings
    #render :text => params[:file][:original_filename]

    if request.post? && params[:file].present?
      Rating.import(params[:file])
      #redirect_to '/employee_masters', notice: "Slides imported."
    else
      redirect_to '/import_ratings', notice: "Ratings couldn't be imported."
    end

  end

end
