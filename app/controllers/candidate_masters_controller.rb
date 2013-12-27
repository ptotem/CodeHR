class CandidateMastersController < InheritedResources::Base
  def new
    @candidate_master = CandidateMaster.new
    @candidate_master.cand_educations.build
    @candidate_master.candidate_contact_numbers.build
    @candidate_master.candidate_employment_histories.build
    @candidate_master.communication_addresses.build
    @candidate_master.candidate_family_details.build
    @candidate_master.job_preferences.build
    @candidate_master.location_preferences.build
    #@rating.write_attribute(:test1, "")
    @fields = DynamicField.where(:oclass=>"CandidateMaster")
    @fields.each do |ss|
      @candidate_master.write_attribute(ss.name.to_sym,"")
    end
  end

end
