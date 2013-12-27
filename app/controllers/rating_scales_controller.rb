class RatingScalesController < InheritedResources::Base

  def new
    @rating_scale = RatingScale.new
    @rating_scale.scales.build
    #@rating.write_attribute(:test1, "")
    @fields = DynamicField.where(:oclass=>"RatingScale")
    @fields.each do |ss|
      @rating_scale.write_attribute(ss.name.to_sym,"")
    end
  end

end
