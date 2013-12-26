class NotificationMastersController < InheritedResources::Base

  def new
    @notification_master = NotificationMaster.new
    #@rating.write_attribute(:test1, "")
    @fields = DynamicField.where(:oclass=>"NotificationMaster")
    @fields.each do |ss|
      @notification_master.write_attribute(ss.name.to_sym,"")
    end
  end
end
