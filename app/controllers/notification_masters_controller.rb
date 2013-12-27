class NotificationMastersController < InheritedResources::Base

  def new
    @notification_master = NotificationMaster.new
    @notification_master.notification_details.build
    @notification_master.email_details.build
    #@rating.write_attribute(:test1, "")
    @fields = DynamicField.where(:oclass=>"NotificationMaster")
    @fields.each do |ss|
      @notification_master.write_attribute(ss.name.to_sym,"")
    end
  end
end
