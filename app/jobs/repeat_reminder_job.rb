module RepeatReminderJob
  @queue = :send_emails
  def self.perform(approval_id)
    @app=ApprovalMat.find(approval_id)
    puts "###################### RepeatReminderJob #########################"
    puts "Inside Send email Job.....#{approval_id}"
    #todo :checking and making it as per the function

    puts "Approval..#{@app._id}"
    puts "Hello Sunny"
    @app.approvers.each do |aa|
      puts "checking"
      @approver=EmployeeMaster.find(aa.employee_master_id)
      unm=@approver.user.notification_masters.build title:@app.name , description:"This is th testing of this mailer",  type:"Approval"
      unm.save
      unm.notification_details.build(:notification_master_id => unm._id,:event=>@app.description)
      unm.email_details.build(:notification_master_id => unm._id,:event=>@app.description)
      unm.save
      @approver.save
      puts "saved"
      AdminMailer.admin_mail(@approver.user.email,"repeat Reminder Approval","Testing").deliver
      puts "reminder mail is delivered"
      #Resque.remove_schedule("send_email_#{@app._id}")
      #call repeat reminder
    end
  end
end
