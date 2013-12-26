class DocumentMastersController < InheritedResources::Base

  def new
    @document_master = DocumentMaster.new
    #@rating.write_attribute(:test1, "")
    @fields = DynamicField.where(:oclass=>"DocumentMaster")
    @fields.each do |ss|
      @document_master.write_attribute(ss.name.to_sym,"")
    end
  end

end
