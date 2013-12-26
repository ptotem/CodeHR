class VacancySchedulingsController < InheritedResources::Base

  def new
    @vacancy_scheduling = VacancyScheduling.new
    #@rating.write_attribute(:test1, "")
    @fields = DynamicField.where(:oclass=>"VacancyScheduling")
    @fields.each do |ss|
      @vacancy_scheduling.write_attribute(ss.name.to_sym,"")
    end
  end
end
