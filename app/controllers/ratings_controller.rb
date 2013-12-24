class RatingsController < InheritedResources::Base

  def new
    @rating = Rating.new
    #@rating.write_attribute(:test1, "")
    @fields = DynamicField.where(:oclass=>"Rating")
    @fields.each do |ss|
      @rating.write_attribute(ss.name.to_sym,"")
    end
  end

  #def create
  #  render :text => params
  #  return
  #end
end
