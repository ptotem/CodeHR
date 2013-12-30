class ManpowerPlanningsController < InheritedResources::Base

  def new
    @manpower_planning = ManpowerPlanning.new
    @manpower_planning.approval_mats.build
    @manpower_planning.vacancy_masters.build
    #@rating.write_attribute(:test1, "")
    @fields = DynamicField.where(:oclass=>"ManpowerPlanning")
    @fields.each do |ss|
      @manpower_planning.write_attribute(ss.name.to_sym,"")
    end
  end
end
