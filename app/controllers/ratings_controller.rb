class RatingsController < InheritedResources::Base

  def new
    @rating = Rating.new
    @rating.score_receiveds.build
    #@rating.write_attribute(:test1, "")
    @fields = DynamicField.where(:oclass=>"Rating")
    @conf=RatingConf.all.asc(:col_sequence)-RatingConf.where(:col_sequence=>nil)
    #render :json => @conf
    #return
    @fields.each do |ss|
      @rating.write_attribute(ss.name.to_sym,"")
    end
  end

  #def create
  #  render :text => params
  #  return
  #end
end
