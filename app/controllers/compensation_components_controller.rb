class CompensationComponentsController < InheritedResources::Base

  def new
    @compensation_component = CompensationComponent.new
    @compensation_component.formula_lists.build
    #@rating.write_attribute(:test1, "")
    @fields = DynamicField.where(:oclass=>"CompensationComponent")
    @fields.each do |ss|
      @compensation_component.write_attribute(ss.name.to_sym,"")
    end
  end
end
