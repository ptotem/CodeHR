class JobDescriptionMastersController < InheritedResources::Base

  def new
    @job_description_master = JobDescriptionMaster.new
    #@rating.write_attribute(:test1, "")
    @fields = DynamicField.where(:oclass=>"JobDescriptionMaster")
    @fields.each do |ss|
      @job_description_master.write_attribute(ss.name.to_sym,"")
    end
  end
end
