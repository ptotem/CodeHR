module SendEmailJob
  @queue = :send_emails
  def self.perform(approval_id)
    puts "Inside Send email Job.....#{approval_id}"
    @app=ApprovalMat.find(approval_id)
    puts "Approval..#{@app._id}"
    #check if deadline...
    #if @app.created_at < @app.created+3
      @app.approvers.each do |aa|
        @approver=EmployeeMaster.find(aa.employee_master_id)
        unm=@approver.user.notification_masters.build title:@approver.name , description:@approver.description,  type:"Approval"
        unm.save
        unm.notification_details.build(:notification_master_id => unm._id,:event=>@approver.content)
        unm.email_details.build(:notification_master_id => unm._id,:event=>@approver.content)
        unm.save
        @approver.save
        AdminMailer.admin_mail(@approver.official_email,"Reminder Approval","#{@app.description @app.link}").deliver
        puts "reinder mail is delivered"
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
