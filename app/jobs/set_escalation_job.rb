module SetEscalationJob
  @queue = :send_emails
  def self.perform(approval_id)
    @app=ApprovalMat.find(approval_id)
    puts "Inside Set Escalation Job.....#{approval_id}"
    puts "Approval..#{@app._id}"
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
      AdminMailer.admin_mail(@approver.user.email,"Escalation","Testing").deliver
      puts "reminder mail is delivered"
      Resque.remove_schedule("send_escalation_#{@app._id}")
      if !@app.rep_escalate.blank?
        @app.repeat_escalation
      end
      #
    end
    #else
    #  #Here the code for starting theescalation process will come.
    #  @remaining_approvers= @app.approvers.where(:approved => false, :active => true)
    #  @remaining_approvers.each do |ra|
    #    ra.active=false
    #    ra.escalated =true
    #    ra.save
    #    #Following code will add another approver to approver list who will be reporting manager of the escalated employee.
    #    @this_app=@app.approvers.create!(:employee_master_id=>EmployeeMaster.find(ra.employee_master_id).reporting_tos.first,active:true,approved:false,escalated:false,escalated_from:ra._id)
    #    @new_app=EmployeeMaster.find(@this_app.employee_master_id)
    #    unm=@new_app.user.notification_masters.build title:@new_app.name , description:@new_app.description,  type:"Approval"
    #    unm.save
    #    unm.notification_details.build(:notification_master_id => unm._id,:event=>@new_app.content)
    #    unm.email_details.build(:notification_master_id => unm._id,:event=>@new_app.content)
    #    unm.save
    #    @new_app.save
    #    AdminMailer.admin_mail(@new_app.official_email,"Approval and Escalation","This mail is came to you because one of you reportee has not yet done approval on following process so you ").deliver
    #    puts "reinder mail is delivered"
    #  end
    #end


  end
end
