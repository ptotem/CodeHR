class InterviewTypesController < InheritedResources::Base

  def new
    @interview_type = InterviewType.new
    #@rating.write_attribute(:test1, "")
    @fields = DynamicField.where(:oclass=>"InterviewType")
    @fields.each do |ss|
      @interview_type.write_attribute(ss.name.to_sym,"")
    end
  end
end
