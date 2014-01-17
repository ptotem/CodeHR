module SendEmailJob
  @queue = :send_emails
  def self.perform(approval_id)
    puts "Inside Send email Job.....#{approval_id}"
    @app=ApprovalMat.find(approval_id)
    @app.approvers.each do |aa|
      @approver=User.find(aa.employee_master_id)
      unm=@approver.notification_masters.build title:@approver.name , description:@approver.description,  type:"Approval"
      unm.save
      unm.notification_details.build(:notification_master_id => unm._id,:event=>@approver.content)
      unm.email_details.build(:notification_master_id => unm._id,:event=>@approver.content)
      unm.save
      @approver.save
      AdminMailer.admin_mail(@approver.email,"Reminder","This is reminder").deliver
      puts "Client mail delivered"
    end
  end
end
