class VacancyMastersController < InheritedResources::Base

  def new
    @vacancy_master = VacancyMaster.new
    #@rating.write_attribute(:test1, "")
    @fields = DynamicField.where(:oclass=>"VacancyMaster")
    @fields.each do |ss|
      @vacancy_master.write_attribute(ss.name.to_sym,"")
    end
  end

end
