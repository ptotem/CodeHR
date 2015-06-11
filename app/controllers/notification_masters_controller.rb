class NotificationMastersController < InheritedResources::Base

  def new
    @form_config= t('config.NotificationMaster.form.new')
    @form=@form_config[:fields]

    @notification_master = NotificationMaster.new
    @notification_master.notification_details.build
    @notification_master.email_details.build
    #@rating.write_attribute(:test1, "")
    @fields = DynamicField.where(:oclass=>"NotificationMaster")
    @fields.each do |ss|
      @notification_master.write_attribute(ss.name.to_sym,"")
    end
  end

  def show
    @notification_master = NotificationMaster.find(params[:id])
    @download = @notification_master.link.split('public')[1]

    @notification_master.read = true
    @notification_master.save

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @notification_master }
    end

  end

  def edit
    @form_config= t('config.NotificationMaster.form.edit')
    @form=@form_config[:fields]
    @notification_master = NotificationMaster.find(params[:id])
  end


  def destroy_all_notifications
    #@notification_masters = NotificationMaster.all
    NotificationMaster.destroy_all
    redirect_to notification_masters_path
  end

  def notifications
    @notifications =current_user.notification_masters.where(:read => false)
    @notifications = @notifications.reverse!
    respond_to do |format|
      format.html
      format.json {render json: @notifications}
    end
  end

end
