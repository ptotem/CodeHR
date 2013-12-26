class DocumentTemplateMastersController < InheritedResources::Base
  def new
    @document_template_master = DocumentTemplateMaster.new
    #@rating.write_attribute(:test1, "")
    @fields = DynamicField.where(:oclass=>"DocumentTemplateMaster")
    @fields.each do |ss|
      @document_template_master.write_attribute(ss.name.to_sym,"")
    end
  end

end
