module SetEscalationJob
  @queue = :send_emails
  def self.perform(approval_id)
    @app=ApprovalMat.find(approval_id)
    puts "Inside Set Escalation Job.....#{approval_id}"
    puts "Approval..#{@app._id}"
    @app.approvers.each do |aa|
      puts "checking"
      @approver=EmployeeMaster.find(aa.employee_master_id)
      unm=@approver.user.notification_masters.build title:@app.name , description:"This is the testing of this mailer",  type:"Approval"
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
  end
end
