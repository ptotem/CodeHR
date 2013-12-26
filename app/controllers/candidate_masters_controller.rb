class CandidateMastersController < InheritedResources::Base
  def new
    @candidate_master = CandidateMaster.new
    #@rating.write_attribute(:test1, "")
    @fields = DynamicField.where(:oclass=>"CandidateMaster")
    @fields.each do |ss|
      @candidate_master.write_attribute(ss.name.to_sym,"")
    end
  end

end
