class DocumentTemplateMastersController < InheritedResources::Base
  def new
    @document_template_master = DocumentTemplateMaster.new
    @document_template_master.document_masters.build
    @document_template_master.notification_masters.build
    #@rating.write_attribute(:test1, "")
    @fields = DynamicField.where(:oclass=>"DocumentTemplateMaster")
    @fields.each do |ss|
      @document_template_master.write_attribute(ss.name.to_sym,"")
    end
  end

end
