require 'resque_scheduler'
class ApprovalMat
  include Mongoid::Document
  field :name, type: String
  field :description, type: String
  field :link, type: String
  field :finished, type: Boolean
  field :process_tr_id, type: String
  field :step_no, type: Integer
  field :employee_master_id, type: String

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
      @approver=User.find(aa.employee_master_id)
      unm=@approver.notification_masters.build title:self.name , description:self.description,  type:"Approval"
      unm.save
      unm.notification_details.build(:notification_master_id => unm._id,:event=>self.description)
      unm.email_details.build(:notification_master_id => unm._id,:event=>self.description)
      unm.save
      @approver.save
      AdminMailer.admin_mail(@approver.email,"Approval Request","#{self.description}").deliver
      puts "Client mail delivered"
    end
    self.schedule_send_email
  end

  def schedule_send_email
    puts ""
    name = "send_email_#{id}"
    config = {}
    config[:class] = 'SendEmailJob'
    config[:args] = id
    config[:every] = '50s'
    Resque.set_schedule name, config
    puts "Resque task is scheduled"
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
