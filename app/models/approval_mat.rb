require 'resque_scheduler'
class ApprovalMat
  include Mongoid::Document
  field :name, type: String
  field :ocls, type: String
  field :oid, type: String
  field :description, type: String
  field :link, type: String
  field :finished, type: Boolean
  field :process_tr_id, type: String
  field :step_no, type: Integer
  field :employee_master_id, type: String
  field :created_at, type: DateTime, default: DateTime.now

  field :approved_next_step, type: String
  field :reject_next_step, type: String
  field :reminder, type: String
  field :rep_reminder, type: String
  field :escalate, type: String
  field :rep_escalate, type: String
  field :auto_assign, type: String


  embeds_many :approvers
  accepts_nested_attributes_for :approvers
  belongs_to :process_tr

  #after_create :schedule_send_email
  #after creation of Approval send notification and email to all the approvers.
  def self.queue; :app; end

  def self.perform
    User.create!(email: "q@qwerty1.com",password: "password", password_confirmation:"password")
  end

  def send_notification
    puts "Inside Send Notification"
    self.approvers.each do |aa|
      @approver=EmployeeMaster.find(aa.employee_master_id)
      unm=@approver.user.notification_masters.build title:self.name , description:self.description,  type:"Approval"
      unm.save
      utask=@approver.user.user_tasks.create title:"Approval Request" , description:"Please visit the url and approve", link:"http://localhost:3000/approval/#{self.ocls}/#{self.oid}/#{self._id}/#{self.process_tr_id}/#{self.step_no}",  type:"Approval", read: false
      utask.save
      unm.notification_details.build(:notification_master_id => unm._id,:event=>self.description)
      unm.email_details.build(:notification_master_id => unm._id,:event=>self.description)
      unm.save
      @approver.save
      link1="http://localhost:3000/approve_process/#{self._id}/#{self.process_tr_id}/#{self.step_no}/#{@approver._id}"
      link2="http://localhost:3000/reject_process/#{self._id}/#{self.process_tr_id}/#{self.step_no}/#{@approver._id}"
      puts link1
      puts link2
      AdminMailer.show_mail(@approver.official_email,"Approval Request","#{self.description}",self.ocls,self.oid,link1,link2).deliver
      puts "Client mail delivered"
    end
    #self.schedule_send_email
    #self.set_escalation
  end

  def schedule_send_email
    puts ""
    name = "send_email_#{id}"
    config = {}
    config[:class] = 'SendEmailJob'
    config[:args] = id
    config[:every] = self.reminder
    Resque.set_schedule name, config
    puts "Resque task is scheduled"
  end

  def schedule_reminder_mail
    #toDo: to send reminder
  end

  def set_repeat_reminder
    #todo: Set repeat every
    puts ""
    name = "repeat_reminder_#{id}"
    config = {}
    config[:class] = 'RepeatReminderJob'
    config[:args] = id
    config[:every] = self.rep_reminder
    Resque.set_schedule name, config
    puts "Resque task is scheduled"
  end

  def set_escalation
    Resque.remove_schedule("repeat_reminder_#{id}")
    puts ""
    name = "set_escalation_#{id}"
    config = {}
    config[:class] = 'SetEscalationJob'
    config[:args] = id
    config[:every] =self.escalate
    Resque.set_schedule name, config
    puts "Resque task is scheduled"
  end

  def repeat_escalation
    #todo: Set repeat every
    puts ""
    name = "repeat_escalation_#{id}"
    config = {}
    config[:class] = 'RepeatEscalationJob'
    config[:args] = id
    config[:every] = self.rep_escalate
    Resque.set_schedule name, config
    puts "Resque task is scheduled"
  end

  def auto_assign
    #todo: write logic of auto assigning1
  end

  def next_step
    @pro=ProcessTr.find(self.process_id)
    if self.approved
      @pro.step_trs[self.step_no].state = "finished"
      @pro.step_trs[self.approved_next_step].initialise_step
    else
      @pro.step_trs[self.reject_next_step..self.step_no].map{|i| i.state = "created"}
      @pro.save
      @pro.step_trs[self.reject_next_step].initialize_step
    end
  end

  def check_resque_scheduler
    puts "Resque testing started..."
    Resque.enqueue_in(15,SendEmailJob)
    puts "Resque task queued successfully...."
  end
end

#class SendEmailJob
#  @queue = :send_emails
#
#  def self.perform
#    # ... do whatever you have to do to send an email to the user
#    puts "The process is "
#    User.create!(email: "q@qwerty1.com",password: "password", password_confirmation:"password")
#  end
#end
