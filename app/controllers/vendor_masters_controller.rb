class VendorMastersController < InheritedResources::Base

  def new
    @vendor_master = VendorMaster.new
    #@rating.write_attribute(:test1, "")
    @fields = DynamicField.where(:oclass=>"VendorMaster")
    @fields.each do |ss|
      @vendor_master.write_attribute(ss.name.to_sym,"")
    end
  end

end
